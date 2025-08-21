import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/services/toko_service.dart';
import '../models/produk_model.dart';

class ProdukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _produkCollection =
      FirebaseFirestore.instance.collection('produk');
  final TokoServices _tokoService = TokoServices();

  Future<List<Produk>> getProdukByToko(String tokoId) async {
    try {
      QuerySnapshot snapshot = await _produkCollection
          .where('id_toko', isEqualTo: tokoId)
          .get();

      if (snapshot.docs.isEmpty) {
        print("Tidak ada produk ditemukan untuk toko dengan ID: $tokoId");
        return [];
      }

      // Ambil objek toko sekali saja
      final toko = await _tokoService.getTokoById(tokoId);

      return snapshot.docs.map((doc) {
        final produk = Produk.fromFirestore(doc);
        return toko != null ? produk.copyWithToko(toko) : produk;
      }).toList();
    } catch (e) {
      print("Error saat mengambil produk by Id Toko: $e");
      return [];
    }
  }

  Future<String> getAlamatTokoByProdukId(String tokoId) async {
    final alamatTokoProduk =
        (await _firestore.collection('toko').doc(tokoId).get())
            .data()?['alamat'];

    return alamatTokoProduk;
  }

  Future<Produk?> getProdukByNama(String nama) async {
    try {
      final snapshot =
          await _produkCollection.where('nama', isEqualTo: nama).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        final produk = Produk.fromFirestore(snapshot.docs.first);
        final toko = await _tokoService.getTokoById(produk.idToko);
        return toko != null ? produk.copyWithToko(toko) : produk;
      }
      return null;
    } catch (e) {
      print("Error saat mengambil produk berdasarkan nama: $e");
      return null;
    }
  }

  Future<List<Produk>> getProdukRandom({int limit = 10}) async {
    try {
      QuerySnapshot snapshot = await _produkCollection.get();
      print('Total produk ditemukan: ${snapshot.docs.length}');

      List<Produk> produkList = [];
      for (var doc in snapshot.docs) {
        final produk = Produk.fromFirestore(doc);
        final toko = await _tokoService.getTokoById(produk.idToko);
        produkList.add(toko != null ? produk.copyWithToko(toko) : produk);
      }

      produkList.shuffle();
      return produkList.take(limit).toList();
    } catch (e) {
      print('Error mengambil produk random: $e');
      return [];
    }
  }

  Stream<List<Produk>> getProdukByTokoStream(String tokoId) {
    return _produkCollection
        .where('id_toko', isEqualTo: tokoId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList(),
        );
  }

  Future<void> addProduct(Produk produk) async {
    try {
      final docRef = _produkCollection.doc();
      final productData = {
        'nama': produk.nama,
        'id_toko': produk.idToko,
        'kategori': produk.kategori,
        'deskripsi': produk.deskripsi,
        'harga': produk.harga,
        'gambar': produk.gambar,
        'rating': produk.rating,
        'jumlah_pembelian': produk.jumlahPembelian,
        'jumlah_disukai': produk.jumlahDisukai,
        'stok': produk.stok,
        'terjual': produk.terjual,
        'timestamp': FieldValue.serverTimestamp(),
      };

      final docSnapShot = await docRef.get();
      if (docSnapShot.exists) {
        await docRef.update(productData);
      } else {
        await docRef.set(productData);
      }
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Stream<List<Produk>> streamProdukByToko(String tokoId) {
    return _produkCollection
        .where('id_toko', isEqualTo: tokoId)
        .snapshots()
        .asyncMap((snapshot) async {
          final toko = await _tokoService.getTokoById(tokoId);
          return snapshot.docs.map((doc) {
            final produk = Produk.fromFirestore(doc);
            return toko != null ? produk.copyWithToko(toko) : produk;
          }).toList();
        });
  }

  Future<void> deleteProduk(String produkId) async {
    try {
      await _produkCollection.doc(produkId).delete();
      print('Produk berhasil dihapus');
    } catch (e) {
      print('Error saat menghapus produk: $e');
    }
  }

  Future<void> updateProdukStok(String produkId, int newStock) async {
    try {
      await _produkCollection.doc(produkId).update({'stok': newStock});
      print('Stok produk berhasil diperbarui');
    } catch (e) {
      print('Error saat update stok: $e');
    }
  }

  Future<void> updateProductStock(String produkId, int amount) async {
    try {
      await _produkCollection
          .doc(produkId)
          .update({'stok': FieldValue.increment(amount)});
      print('Stock for product $produkId has been updated by $amount.');
    } catch (e) {
      print('Error updating stock: $e');
    }
  }

  Future<void> decreaseProductStock(String produkId, int amount) async {
    await updateProductStock(produkId, -amount);
  }
}
