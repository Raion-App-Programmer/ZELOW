import 'package:flutter/material.dart';
import 'package:zelow/components/keranjang_card.dart';
import 'package:zelow/components/keranjang_bottomnavbar.dart';
import 'package:zelow/models/keranjang_model.dart';
import 'package:zelow/services/keranjang_service.dart';


// class KeranjangKu extends StatefulWidget {
//   const KeranjangKu({super.key});

//   @override
//   State<KeranjangKu> createState() => _KeranjangKuState();
// }

// class _KeranjangKuState extends State<KeranjangKu> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff06C474),
//         toolbarHeight: 92,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "KeranjangKu",
//           style: TextStyle(
//             fontSize: MediaQuery.of(context).size.width * 0.05,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 16,),
//             //SAMPLE
//             CardItemSample(),
//             CardItemSample(),
//             CardItemSample(),
//             CardItemSample(),
//             CardItemSample(),
//             CardItemSample(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CartBottomNavBar(),
//     );
//   }
// }

class KeranjangKu extends StatefulWidget {
  const KeranjangKu({super.key});

  @override
  State<KeranjangKu> createState() => _KeranjangKuState();
}

class _KeranjangKuState extends State<KeranjangKu> {
  // List<Product> _products = List.generate(
  //   6,
  //   (index) => Product(
  //     name: "Nasi Padang, Ayam Kare",
  //     imagePath: 'assets/images/naspad.jpg',
  //     quantity: 1,
  //     price: 13000,
  //     originalPrice: 23000,
  //   ),
  // );

  // Backend Keranjang
  final KeranjangService _keranjangService = KeranjangService();

  // void toggleSelection(int index) {
  //   setState(() {
  //     _products[index].isSelected = !_products[index].isSelected;
  //   });
  // }

  // int get selectedCount => _products.where((p) => p.isSelected).length;

  // double get totalPrice => _products
  //     .where((p) => p.isSelected)
  //     .fold(0, (sum, p) => sum + (p.price * p.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff06C474),
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "KeranjangKu",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: List.generate(_products.length, (index) {
      //       return GestureDetector(
      //         onTap: () => toggleSelection(index),
      //         child: CardItemSample(
      //           product: _products[index],
      //           onTap: () => toggleSelection(index),
      //         ),
      //       );
      //     }),
      //   ),
      // ),
      body: StreamBuilder<List<KeranjangItem>>(
        stream: _keranjangService.getCartItems(),
        builder: (context, snapshot) {

          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang Masih Anda Kosong',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final cartItems = snapshot.data!;

          // Menampilkan data keranjang
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Dismissible(
                key: Key(item.produk.idProduk),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _keranjangService.removeFromCart(item.produk.idProduk);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.produk.nama} dihapus dari keranjang.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },

                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: CardItemSample(
                  item: item,
                  onTap: () {
                    
                    print('${item.produk.nama} ditekan');
                  },
                ),
              );
            },
          );
        },
      ),

      // bottomNavigationBar: CartBottomNavBar(
      //   totalPrice: totalPrice,
      //   itemCount: selectedCount,
      // ),

      bottomNavigationBar: CartBottomNavBar(
        totalPrice: 0, // Kalkulasi total harga bisa jadi langkah selanjutnya
        itemCount: 0,  // Kalkulasi jumlah item juga
      ),
    );
  }
}
