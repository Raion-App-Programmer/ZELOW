import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/pages/auth/login_page.dart';
import 'package:zelow/pages/user/display_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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

    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
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
          return const Scaffold(body: Center(child: Text('User not found')));
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;

        final String username = userData['username'] ?? 'Unknown';
        final String email = userData['email'] ?? 'No email';
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: zelow,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Profil',
              style: whiteTextStyle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // for the profile, name, email, edit profil icons
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xff06C474),
                                width: 1,
                              ),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/user.png',
                                ),
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
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DisplayProfile(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/pen.png'),
                                      SizedBox(width: 3.41),
                                      Text(
                                        'Edit profil',
                                        style: greyTextStyle.copyWith(
                                          decoration: TextDecoration.underline,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Aktivitas',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/heart_icon.png',
                        ),
                        description: 'Favorit Saya',
                      ),
                      SizedBox(height: 16),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/write_icon.png',
                        ),
                        description: 'Review Saya',
                      ),
                      SizedBox(height: 16),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/voucher_icon.png',
                        ),
                        description: 'Voucher Saya',
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Pengaturan Akun',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/location_icon.png',
                        ),
                        description: 'Alamat Saya',
                      ),
                      SizedBox(height: 16),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/security_icon.png',
                        ),
                        description: 'Keamanan Akun',
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Pengaturan Umum',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/voucher_icon.png',
                        ),
                        description: 'Pengaturan Chat',
                      ),
                      SizedBox(height: 16),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/voucher_icon.png',
                        ),
                        description: 'Pengaturan Notifikasi',
                      ),
                      SizedBox(height: 16),
                      IconTextMaker(
                        leadingIcon: Image.asset(
                          'assets/images/voucher_icon.png',
                        ),
                        description: 'Bahasa & Masukan',
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: 300,
                                height: 160,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(16),
                                  ),
                                  backgroundColor: Color(0xffFEFEFE),
                                  title: Column(
                                    children: [
                                      Text(
                                        'Keluar',
                                        style: blackTextStyle.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: Color(0xff252525),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Yakin nih mau keluar? :(',
                                        style: greyTextStyle.copyWith(
                                          color: Color(0xff929292),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xff06C474,
                                                ),
                                                elevation: 0,
                                                fixedSize: Size.fromHeight(34),
                                              ),
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            LoginPage(),
                                                  ),
                                                  (route) => false,
                                                );
                                              },
                                              child: Text(
                                                'Keluar',
                                                style: whiteTextStyle,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ), // space between the two buttons
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                fixedSize: Size.fromHeight(34),
                                                side: BorderSide(
                                                  color: Color(0xff06C474),
                                                  width: 1,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(
                                                  context,
                                                ).pop(); // close the dialog
                                              },
                                              child: Text(
                                                'Batal',
                                                style: greenTextStyle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: IconTextMaker(
                          leadingIcon: Image.asset(
                            'assets/images/mdi_logout.png',
                          ),
                          description: 'Keluar',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNav(selectedItem: 4),
        );
      },
    );
  }
}

// buat buat yang icon dan teks aktivitas, pengaturan akun, pengaturan umum
class IconTextMaker extends StatelessWidget {
  final Image leadingIcon;
  final String description;

  const IconTextMaker({
    super.key,
    required this.leadingIcon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leadingIcon,
            SizedBox(width: 12),
            Text(
              description,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios, color: Color(0xff8A8A8A)),
      ],
    );
  }
}
