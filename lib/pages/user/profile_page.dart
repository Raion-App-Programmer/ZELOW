import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    String username = user?.displayName ?? 'Lalalili';
   String email = user?.email ?? 'lalalili@gmail.com';
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
          )
           ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.06, top: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row( // for the profile, name, email, edit profil icons 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff06C474),
                            width: 1,
                          )
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/user.png'),
                            backgroundColor: Color(0xffE6F9F1),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06, top: MediaQuery.of(context).size.height * 0.01),
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
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Image.asset('assets/images/pen.png'),
                                SizedBox(width: 3.41,),
                                Text(
                                  'Edit profil',
                                  style: greyTextStyle.copyWith(
                                    decoration: TextDecoration.underline,
                  
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.02),
                  Text(
                    'Aktivitas',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16, 
                    ),
                  ),
                  SizedBox(height: 8,),
                  IconTextMaker(leadingIcon: Image.asset(
                    'assets/images/heart_icon.png',
                    ), 
                    description: 'Favorit Saya',
                    ),
                  SizedBox(height: 16,),
                  IconTextMaker(
                    leadingIcon: Image.asset('assets/images/write_icon.png'), 
                  description: 'Review Saya'),
                  SizedBox(height: 16,),
                  IconTextMaker(
                    leadingIcon: Image.asset('assets/images/voucher_icon.png'), 
                    description: 'Voucher Saya'),
                  SizedBox(height: 32,),
                  Text(
                    'Pengaturan Akun',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8,),
                  IconTextMaker(
                    leadingIcon: Image.asset('assets/images/location_icon.png'), 
                    description: 'Alamat Saya'
                    ),
                    SizedBox(height: 16,),
                    IconTextMaker(
                      leadingIcon: Image.asset('assets/images/security_icon.png'), 
                      description: 'Keamanan Akun'
                    ),
                    SizedBox(height: 32,),
                    Text(
                      'Pengaturan Umum',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8,),
                    IconTextMaker(
                      leadingIcon: Image.asset('assets/images/voucher_icon.png'), 
                      description: 'Pengaturan Chat'),
                      SizedBox(height: 16,),
                       IconTextMaker(
                      leadingIcon: Image.asset('assets/images/voucher_icon.png'), 
                      description: 'Pengaturan Notifikasi'),
                      SizedBox(height: 16,),
                       IconTextMaker(
                      leadingIcon: Image.asset('assets/images/voucher_icon.png'), 
                      description: 'Bahasa & Masukan'),
                      SizedBox(height: 32,),
                      IconTextMaker(
                        leadingIcon: Image.asset('assets/images/mdi_logout.png'), 
                        description: 'Keluar')
                ],
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 4),
    );
  }
}

// buat buat yang icon dan teks aktivitas, pengaturan akun, pengaturan umum
class IconTextMaker extends StatelessWidget {
   final Image leadingIcon; 
   final String description; 

   const IconTextMaker({super.key, required this.leadingIcon, required this.description});


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
        Icon(
          Icons.arrow_forward_ios,
          color: Color(0xff8A8A8A),
          ),
      ],
    );
  }
}