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
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child:
            Image.asset(
              'assets/images/toko_header_dummy.png', // gambar header dummy
              fit: BoxFit.cover
            ),
          ),
        ),
        //mainAxisAlignment: MainAxisAlignment.center,
        // Tombol Search, Favorite dan Share pojok atas
        Positioned(
          top: 20,
          right: 10,
          child: Row(
            children: [
              _buildIconButton(Icons.search),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite; // Toggle status favorit
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
                    color: isFavorite ? Colors.red : zelow, // Merah jika favorit, hijau jika tidak
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _buildIconButton(Icons.share_outlined)
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, color: Colors.white, size: 35), // Ikon lokasi
                const SizedBox(width: 8)
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk membuat tombol bulat putih
  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, color: zelow), // Ikon hijau
    );
  }
}
