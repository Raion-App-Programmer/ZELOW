import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zelow/pages/auth/login_page.dart';
import 'package:zelow/pages/auth/register_page.dart';
import 'package:zelow/components/constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Selamat Datang!',
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sudah punya akun?',
                    style: greyTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Image.asset(
                'assets/images/zelowbottom.png',
                height: 200,
                width: 200,
              ),

              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        color: const Color(0xff06C474),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          "Masuk",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: const Color(0xff06C474),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          "Buat Akun",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff06C474),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
