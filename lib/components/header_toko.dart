import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class HeaderToko extends StatefulWidget {
  // Backend
  final String imageUrl;

  const HeaderToko({super.key, required this.imageUrl});

  @override
  _HeaderTokoState createState() => _HeaderTokoState();
}

class _HeaderTokoState extends State<HeaderToko> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/toko_header_dummy.png',
                fit: BoxFit.cover,
              );
            },

            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  color: zelow,
                ),
              );
            },
          )
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
                const SizedBox(width: 8),
                
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
