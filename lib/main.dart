import 'package:firebase_core/firebase_core.dart';
import 'package:zelow/pages/umkm/income_report.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:zelow/pages/auth/login_page.dart';
import 'package:zelow/pages/umkm/home_page_umkm.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/home_page_user.dart';
import 'package:zelow/pages/user/pesanan_page.dart';
import 'package:zelow/pages/user/profile_page.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/pages/user/chat_page.dart';

import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home_page_user',
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => SplashPage(),
        '/home_page_user': (context) => HomePageUser(),
        '/home_page_umkm': (context) => HomePageUmkm(),
        '/login_page': (context) => LoginPage(),
        '/flashsale': (context) => FlashsalePage(),
        '/pesanan': (context) => PesananPage(orders: []),
        '/profile': (context) => ProfilePage(),
        '/chat': (context)=> chatPage(),
        '/laporan': (context) => incomeReport(),
      },
    );
  }
}
