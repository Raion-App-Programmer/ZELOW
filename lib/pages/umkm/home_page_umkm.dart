import 'package:flutter/material.dart';
import 'package:zelow/pages/umkm/income_report.dart';

import '../../components/constant.dart';
import '../../services/auth_service.dart';

class HomePageUmkm extends StatefulWidget {
  const HomePageUmkm({super.key});

  @override
  State<HomePageUmkm> createState() => _HomePageUmkmState();
}

class _HomePageUmkmState extends State<HomePageUmkm> {

  void _handleLogout() {
    AuthService().logout(context);
  }

  void _tes(){
    Navigator.pushReplacementNamed(context, '/laporan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text("Home Page Umkm", style: TextStyle(color: black)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _tes,
            icon: Icon(Icons.logout, color: black),
          ),
        ],
      ),
    );
  }
}
