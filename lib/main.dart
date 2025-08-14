import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'package:zelow/pages/splash_page.dart';
import 'package:zelow/pages/auth/login_page.dart';
import 'package:zelow/pages/umkm/home_umkm_page.dart';
import 'package:zelow/pages/umkm/stok_toko_umkm.dart';
import 'package:zelow/pages/umkm/tambah_produk_umkm.dart';
import 'package:zelow/pages/umkm/income_report.dart';
import 'package:zelow/pages/user/home_page_user.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/pesanan_page.dart';
import 'package:zelow/pages/user/profile_page.dart';
import 'package:zelow/pages/user/chat_page.dart';
import 'package:zelow/pages/user/toko_page_user.dart';

const SUPABASE_URL = 'https://gegrqxsyhqestdtmqadq.supabase.co';
const SUPABASE_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdlZ3JxeHN5aHFlc3RkdG1xYWRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwMTE4NTMsImV4cCI6MjA2ODU4Nzg1M30.fN53ULmrrSKJGbrj_w1AqtD2nneVKThP1elhF7v3sso';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inisialisasi format tanggal Indonesia
  await initializeDateFormatting('id_ID', null);

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: SUPABASE_KEY,
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login_page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nunito'),
      routes: {
        '/splash': (context) => SplashPage(),
        '/home_page_user': (context) => HomePageUser(),
        '/home_page_umkm': (context) => HomePageUmkm(),
        '/login_page': (context) => LoginPage(),
        '/flashsale': (context) => FlashsalePage(),
        '/pesanan': (context) => PesananPage(), 
        '/profile': (context) => ProfilePage(),
        '/toko': (context) => TokoPageUser(), 
        '/chat': (context) => chatPage(),
        '/laporan': (context) => IncomeReport(), 
        '/stok': (context) => StokTokoUmkm(),
        '/tambahProduk': (context) => TambahProdukUmkm(),
      },
    );
  }
}
