import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/pages/umkm/tambah_produk_umkm.dart';
import 'package:zelow/services/produk_service.dart';
import 'package:zelow/services/toko_service.dart';

class StokTokoUmkm extends StatefulWidget {
  const StokTokoUmkm({super.key});

  @override
  State<StokTokoUmkm> createState() => _StokTokoUmkmState();
}

class _StokTokoUmkmState extends State<StokTokoUmkm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TokoServices _tokoService = TokoServices();
  String? _currentTokoId;

  @override
  void initState(){
    super.initState();
    _loadTokoId();
  }

  Future<void>_loadTokoId() async{
    String? tokoId = await _tokoService.getIDToko();
    setState(() {
      _currentTokoId = tokoId;
    });
    if(tokoId == null && mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda belum memiliki toko atau belum login.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: zelow,
          leading: IconButton(onPressed: () => Navigator.pushReplacementNamed(context,'/home_page_umkm'),
              icon: const Icon(Icons.arrow_back, color: Colors.white,)
          ),
          title: Text(
            'Stok di ZeUp',
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: _currentTokoId == null? Center(child: CircularProgressIndicator())
                  : DummyStok(tokoID: _currentTokoId!)
            ),
            TambahProduk(),
            SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),))
          ],
        )
    );
  }
}

class TambahProduk extends StatelessWidget {
  const TambahProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                fixedSize: const Size(353, 44),
                backgroundColor: Color(0xff06C474)
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TambahProdukUmkm(),
                  )
              ).then((result){
                if(result == true){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Produk berhasil ditambahkan')),
                  );
                }
              }
              );
            },
            child: Text(
              'Tambah Produk',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16
              ),
            )
        )
      ],
    );
  }
}

class cardProduct extends StatefulWidget{
  final String tokoID;
  final Produk produk;
  final ProdukService produkService;

  const cardProduct({
    super.key,
    required this.tokoID,
    required this.produk,
    required this.produkService,

});

  @override
  State<cardProduct> createState() => _cardProductState();
}

class _cardProductState extends State<cardProduct> {
  int _currentStock = 0;
  bool _isAvailable = true;


  @override
  void initState() {
    super.initState();
    _currentStock = widget.produk.stok;
    // _produkFuture = _produkService.getProdukByToko(widget.tokoID);
  }

  void increaseStock() {
    setState(() {
      _currentStock++;
      widget.produkService.updateProdukStok(widget.produk.id, widget.tokoID, _currentStock);
    });
  }

  void decreaseStock() {
    if (_currentStock > 0) {
      setState(() {
        _currentStock--;
        widget.produkService.updateProdukStok(widget.produk.id, widget.tokoID, _currentStock);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xffE6E6E6),
            width: 2,
          ),
        ),
        child:
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                    ),
                    width: 94.30,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),

                    child: Image.network(
                      '${widget.produk.gambar}',
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator();
                      },
                        errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                  },
                    ),
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.produk.nama}',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'RP${widget.produk.harga}',
                      style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${widget.produk.stok} | Tersedia',
                          style: greenTextStyle.copyWith(
                            wordSpacing: 4,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        // increment and decrement button
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff06C474)),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                // decrement button
                                GestureDetector(
                                  onTap: decreaseStock,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: widget.produk.stok > 0 ? Color(
                                          0xff06C474) : Color(0xffE6E6E6),
                                    ),
                                  ),
                                ),
                                // current stock
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '${widget.produk.stok}',
                                    style: greenTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                // increment button
                                GestureDetector(
                                  onTap: increaseStock,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Color(0xff06C474),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              children: [
                Switch(
                  value: _isAvailable,
                  onChanged: (bool value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                  activeColor: Colors.green,
                  thumbColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {

                        return Colors.white;
                      }
                      return Colors.white;
                    },
                  ),
                ),
                Text(
                  'Tampilkan',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),

    );
  }
}


class DummyStok extends StatefulWidget {
  final String tokoID;
  const DummyStok({super.key, required this.tokoID});



  @override
  State<DummyStok> createState() => _DummyStokState();
}

class _DummyStokState extends State<DummyStok> {
  int _currentStock = 0;
  bool _isAvailable = true;
  final ProdukService _produkService = ProdukService();
//  late Future<List<Produk>> _produkFuture;

  @override
  Widget build(BuildContext context){
  if (widget.tokoID.isEmpty) {
  return const Center(child: Text('ID Toko tidak valid.'));
  }

  return Padding(
  padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
  child: StreamBuilder<List<Produk>>(
  stream: _produkService.streamProdukByToko(widget.tokoID),
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
  return const Center(child: CircularProgressIndicator());
  } else if (snapshot.hasError) {
  return Text('Error: ${snapshot.error}');
  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  return const Center(child: Text('Tidak ada produk ditemukan.'));
  } else {
  List<Produk> produkList = snapshot.data!;
  return ListView.builder(
  itemCount: produkList.length,
  itemBuilder: (context, index) {
    Produk produk = produkList[index];
    return cardProduct(tokoID: widget.tokoID, produk: produk, produkService: _produkService);
    }
    );
    }
    }
      ));
      }
}