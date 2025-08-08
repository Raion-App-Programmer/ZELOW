import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/user/edit_profile.dart';
import 'package:zelow/pages/auth/login_page.dart';


class DisplayProfile extends StatelessWidget {
  const DisplayProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
  Future.microtask(() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  });
  return const Scaffold(
    body: Center(child: Text("User not logged in... redirecting")),
  );
}

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("User data not found.")),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;

        final String username = userData['username'] ?? 'Unknown';
        final String email = userData['email'] ?? 'No email';
        final String fullname = userData['fullname'] ?? 'No name';
        // Testing something
        return Scaffold(
          appBar: AppBar(
            backgroundColor: zelow,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Profil',
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
                top: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff06C474),
                                width: 1,
                              ),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                                backgroundColor: Color(0xffE6F9F1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(email),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DisplayProfile()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/pen.png'),
                                      const SizedBox(width: 3.41),
                                      Text(
                                        'Edit profil',
                                        style: greyTextStyle.copyWith(
                                          decoration:
                                              TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),
                  Row(
                    children: [
                      Text(
                        'Informasi Pribadi',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()),
                          );
                        },
                        child: Image.asset('assets/images/pen.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 353,
                    height: 101,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffFEFEFE),
                      border: Border.all(color: const Color(0xffE6E6E6)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabelRow('Nama', fullname),
                          buildLabelRow('Jenis Kelamin', 'Perempuan'),
                          buildLabelRow('Tanggal Lahir', '22 Februari 2002'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Text(
                        'Informasi Akun',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DisplayProfile()),
                          );
                        },
                        child: Image.asset('assets/images/pen.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xffFEFEFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                          color: Color(0xffE6E6E6),
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nomor Telepon',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          size: 26,
                          color: Color(0xff06C474),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xffFEFEFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                          color: Color(0xffE6E6E6),
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          size: 26,
                          color: Color(0xff06C474),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildLabelRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const Text(': ', style: TextStyle(fontSize: 12)),
      Expanded(
        child: Text(
          value,
          style: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
