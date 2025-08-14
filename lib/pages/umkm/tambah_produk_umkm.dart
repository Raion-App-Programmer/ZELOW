

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';


class TambahProdukUmkm extends StatelessWidget {
  const TambahProdukUmkm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        title: Text(
          'Tambah Produk',
          style: whiteTextStyle.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20
          )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ), 
        centerTitle: true,
      ),
      body: TambahProdukForm(onSubmit: (
        judul, 
        kategori, 
        deskripsi, 
        harga,
        fotoProdukUrl) {

      }
      ),
      );
  }
}

class TambahProdukForm extends StatefulWidget {
  final void Function(
    String judul,
    String kategori,
    String deskripsi,
    double harga, 
    File? fotoProdukUrl,
    ) onSubmit;
  const TambahProdukForm({
    super.key,
    required this.onSubmit
    });

  @override
  State<TambahProdukForm> createState() => _TambahProdukFormState();
}

class _TambahProdukFormState extends State<TambahProdukForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  // dropdown
  String? _selectedKategori;
  final List<String> _opsiKategori = [
    'Aneka Nasi',
    'Minuman',
    'Jajanan Ringan',
    'Lauk Pauk'
  ];

// image
File? _pickedImage; 

// form validity tracker
bool _isFormValid = false;

// method to check if form is valid
void _checkFormValidity() {
  final bool currentFormValidity = 
  _judulController.text.isNotEmpty &&
  _deskripsiController.text.isNotEmpty &&
  _hargaController.text.isNotEmpty && 
  double.tryParse(_hargaController.text) != null && 
  _selectedKategori != null && 
  _pickedImage != null;

  if (_isFormValid != currentFormValidity) {
    setState(() {
      _isFormValid = currentFormValidity;
    });
  } 
}

@override
void initState() {
  super.initState();
  // listeners
  _judulController.addListener(_checkFormValidity);
  _deskripsiController.addListener(_checkFormValidity);
  _hargaController.addListener(_checkFormValidity);
}

// image picking 
Future<void> _pickImage() async {
  final picker = ImagePicker(); 
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _pickedImage = File(pickedFile.path);
      _checkFormValidity();
    });
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pemilihan gambar batal')),
      );
    }
  }
}

  // remove image
  void _removeImage() {
    setState(() {
      _pickedImage == null;
      _checkFormValidity();
    });
  }

  // dispose controller
  @override
  void dispose() {
    _judulController.removeListener(_checkFormValidity);
    _deskripsiController.removeListener(_checkFormValidity);
    _hargaController.removeListener(_checkFormValidity);
    _judulController.dispose();
    _deskripsiController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  // handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedKategori == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mohon pilih kategori produk.'),),
        );
        return;
      }
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon tambahkan foto produk.')),
        );
        return;
      }
      // form valid
      widget.onSubmit(
        _judulController.text,
        _selectedKategori ?? 'Aneka Nasi',
        _deskripsiController.text,
        double.tryParse(_hargaController.text) ?? 0.0,
        _pickedImage,
      );
    }
  }

  // page
 @override
 Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          // judul
          Text(
            'Judul',
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              color: Color((0xffEFEFEF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              controller: _judulController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Nama',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                } 
                return null;
              },
              onChanged: (_) => _checkFormValidity(),
            ),
          ),
          SizedBox(height: 16,),
          // kategori
          Text(
            'Kategori',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedKategori,
                hint: Text('Aneka Nasi'),
                icon: Image.asset('assets/images/dropdown_arrow.png'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedKategori = newValue;
                    _checkFormValidity();
                  });
                }, 
                items: _opsiKategori.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                    );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 16,),
          // deskripsi
          Text(
            'Deskripsi',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              controller: _deskripsiController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tambah deskripsi singkat',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi tidak boleh kosong';
                }
                return null;
              },
              onChanged: (_) => _checkFormValidity(),
            ),
          ),
          SizedBox(height: 16,),
          // harga
          Text(
            'Harga',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              controller: _hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Tambah harga',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harga tidak boleh kosong';
                }
                if (double.tryParse(value) == null) {
                  return 'Angka tidak valid';
                } 
                return null;
              },
              onChanged: (_) => _checkFormValidity(),
            ),
          ),
          SizedBox(height: 16,),
          // foto produk
          Text(
            'Foto Produk',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8,),
          GestureDetector(
            onTap:_pickImage,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(16),
              padding: EdgeInsets.zero,
              color: Color(0xff06C474),
              strokeWidth: 2,
              dashPattern: [8,4],
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _pickedImage == null ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff06C474),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Tambah Gambar',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ):
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _pickedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _removeImage,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
          SizedBox(height: 24,),
          // tambahkan produk button
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _isFormValid ? _submitForm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid ? Color(0xff06C474) : Color(0xffE6E6E6),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text(
                  'Tambahkan Produk',
                  style: blackTextStyle.copyWith(
                    color: _isFormValid ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
                ],
              ),
            ),
          );
        }
      }