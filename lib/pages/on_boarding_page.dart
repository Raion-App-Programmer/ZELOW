import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/welcome_page.dart';
import 'package:zelow/pages/auth/register_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  void goToNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          buildOnBoarding(
            context,
            image: 'assets/images/on_boarding_1.png',
            title: 'Food Waste Solution',
            subtitle: 'Bantu kurangi food waste & \nhemat biaya makanan.',
            slideImage: 'assets/images/slide_image_1.png',
            onNext: goToNextPage,
          ),
          buildOnBoarding(
            context,
            image: 'assets/images/on_boarding_2.png',
            title: 'Flash Sale & Surprise Bag',
            subtitle:
                'Dapatkan diskon & surprise bag \ndengan harga makin terjangkau!',
            slideImage: 'assets/images/slide_image_2.png',
            onNext: goToNextPage,
          ),
          buildOnBoarding(
            context,
            image: 'assets/images/on_boarding_3.png',
            title: 'Mudah & Cepat',
            subtitle:
                'Pesan makanan favoritmu, \nbayar dengan berbagai metode.',
            slideImage: 'assets/images/slide_image_3.png',
            onNext: goToNextPage,
          ),
          buildLastPage(context),
        ],
      ),
    );
  }

  Widget buildOnBoarding(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    required String slideImage,
    required VoidCallback onNext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: greyTextStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(slideImage),
              GestureDetector(
                onTap: onNext,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xff06C474),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLastPage(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/zelowbottom.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Gabung Sekarang!',
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mulai jelajahi makanan hemat &\nberkualitas di sekitarmu!',
                    style: greyTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomePage()),
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
                        "Mulai",
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
                      MaterialPageRoute(builder: (_) => const SignUp()),
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
    );
  }
}
