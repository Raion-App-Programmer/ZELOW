import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class HeaderToko extends StatefulWidget {
  const HeaderToko({super.key});

  @override
  _HeaderTokoState createState() => _HeaderTokoState();
}

class _HeaderTokoState extends State<HeaderToko> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3, // 30% tinggi layar
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image yang menutupi seluruh area
          Image.asset(
            'assets/images/toko_header_dummy.png',
            fit: BoxFit.cover, // Menutupi seluruh area
          ),

          // Tombol search, favorite, share
          Positioned(
            top: 30,
            right: 10,
            child: Row(
              children: [
                _buildIconButton(Icons.search),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : zelow,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _buildIconButton(Icons.share_outlined),
              ],
            ),
          ),

          // Tombol kembali di kiri atas
          Positioned(
            top: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget tombol bulat putih
  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, color: zelow),
    );
  }
}
