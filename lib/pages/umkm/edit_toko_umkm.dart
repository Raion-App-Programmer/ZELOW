import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/navbar_toko.dart';

class EditTokoSayaPage extends StatefulWidget {
  const EditTokoSayaPage({Key? key}) : super(key: key);

  @override
  _EditTokoSayaPageState createState() => _EditTokoSayaPageState();
}

class _EditTokoSayaPageState extends State<EditTokoSayaPage> {
  bool isOpen = false; // Track whether the store is open or closed

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: zelow,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0), // Atur padding atas
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 35.0), // Atur padding atas
            child: Text(
              'Edit Toko',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 34.0, right: 25.0),
              child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: Column(
          children: [
            Container(
              height: 40,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Nama'),
              ),
            ),
            Container(
              height: 50, // Adjust height as needed
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0), // Makes the border rounded
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Kontak'),
              ),
            ),
            Container(
              height: 50, // Adjust height as needed
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0), // Makes the border rounded
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Alamat'),
              ),
            ),
            Container(
              height: 50, // Adjust height as needed
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0), // Makes the border rounded
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Nama'),
              ),
            ),
            Container(
              height: 50, // Adjust height as needed
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0), // Makes the border rounded
                            borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
      bottomNavigationBar: const NavbarToko(selectedItem: 1),
    );
  }
}
