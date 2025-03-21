import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _currentIndex = 0; // Untuk indikator titik-titik

  final List<String> imgList = [
    "assets/images/Poster.png",
    "assets/images/poster 2.png",
    "assets/images/poster 3.png",
    "assets/images/poster 4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Slider Gambar
        Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: zelow, width: 3),
         ), 
      ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.25, // Tinggi slider
          child: PageView.builder(
            itemCount: imgList.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                child: Image.asset(
                  imgList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        ),

        Positioned(
          bottom: 65, 
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                imgList.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Tombol Notifikasi & Keranjang di Pojok Kanan Atas
        Positioned(
          top: 20,
          right: 10,
          child: Row(
            children: [
              _buildIconButton(Icons.notifications),
              const SizedBox(width: 10),
              _buildIconButton(Icons.shopping_bag_rounded),
            ],
          ),
        ),
         Positioned(
          top: 20,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6), // Hitam dengan opacity 60%
              borderRadius: BorderRadius.circular(24), // Box rounded
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.white), // Ikon lokasi
                const SizedBox(width: 8),
                Text(
                  "Jl. Cibaduyut", // Alamat dummy
                  style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.035),
                ),
              ],
            ),
          ),
        ),
        // Search Bar Mengambang di Bawah Slider
        
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
