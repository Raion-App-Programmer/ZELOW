import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/order_item_card.dart';
import 'package:zelow/pages/user/pesanan_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const CheckoutPage({super.key, required this.orders});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<Map<String, dynamic>> orders;
  double serviceFee = 4900.0;
  String _selectedPayment = "cash";
  

  String getMonthName(int month) {
    List<String> months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return months[month - 1];
  }

  @override
  void initState() {
    super.initState();
    orders = List.from(widget.orders);
     
  }

  void _increaseQuantity(int index) {
    setState(() {
      orders[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    if (orders[index]['quantity'] > 1) {
      setState(() {
        orders[index]['quantity']--;
      });
    }
  }

  void _showOrderTypeModal(BuildContext context) {
    String _selectedTab = "Pick Up"; // Default Pick Up
    String _selectedSchedule = "10:00 - 11:00"; // Default Radio Button

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedTab = "Pick Up";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedTab == "Pick Up"
                                    ? zelow
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: zelow),
                            ),
                          ),
                          child: Text(
                            "Pick Up",
                            style: TextStyle(
                              color:
                                  _selectedTab == "Pick Up"
                                      ? Colors.white
                                      : zelow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedTab = "Delivery";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedTab == "Delivery"
                                    ? zelow
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: zelow),
                            ),
                          ),
                          child: Text(
                            "Delivery",
                            style: TextStyle(
                              color:
                                  _selectedTab == "Delivery"
                                      ? Colors.white
                                      : zelow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  _selectedTab == "Pick Up"
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ambil Langsung ke Toko",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Langsung ambil belanjaanmu tanpa perlu menunggu",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.store, color: zelow),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Masakan Padang Roda Dua\nJl. jalan No. X, Landungsari, Kota Malang",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Buka 07:00 - 23:00",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Informasi Toko",
                            style: TextStyle(
                              color: zelow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Jadwal Pengambilan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Pilih Jadwal yang tersedia"),
                          SizedBox(height: 8),
                          Column(
                            children: [
                              ListTile(
                                leading: Radio(
                                  value: "10:00 - 11:00",
                                  groupValue: _selectedSchedule,
                                  activeColor: zelow,
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedSchedule = val.toString();
                                    });
                                  },
                                ),
                                title: Text("10:00 - 11:00"),
                              ),
                              ListTile(
                                leading: Radio(
                                  value: "21:00 - 22:00",
                                  groupValue: _selectedSchedule,
                                  activeColor: zelow,
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedSchedule = val.toString();
                                    });
                                  },
                                ),
                                title: Text("21:00 - 22:00"),
                              ),
                            ],
                          ),
                        ],
                      )
                      : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image.asset("assets/images/logo_zelow.png", width: 100),
                            SizedBox(height: 12),
                            Text(
                              "Coming Soon",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: zelow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Terapkan",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double get subtotal {
    return orders.fold(
      0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: whiteTextStyle),
        leading: BackButton(color: white),
        backgroundColor: zelow,
        iconTheme: IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat Resto",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Jalan Bedungan Sutami No12, Penanggungan, Klojen, Kota Malang",
              ),
              SizedBox(height: 16),
              Text(
                "Tipe Pemesanan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    _showOrderTypeModal(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pilih Tipe Pemesanan"),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Rincian Pesanan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children:
                    orders.asMap().entries.map((entry) {
                      int index = entry.key;
                      var item = entry.value;
                      return OrderItemCard(
                        imageUrl: item['imageUrl'],
                        title: item['title'],
                        price: item['price'],
                        originalPrice: item['originalPrice'],
                        quantity: item['quantity'],
                        onIncrease: () => _increaseQuantity(index),
                        onDecrease: () => _decreaseQuantity(index),
                      );
                    }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                "Rincian Pembayaran",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Biaya Layanan", style: blackTextStyle),
                        Text("Rp$serviceFee", style: blackTextStyle),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp${subtotal + serviceFee}",
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mau pake voucher?", style: blackTextStyle),
                    Icon(Icons.arrow_forward_ios, size: 16, color: zelow),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Metode Pembayaran",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Radio(
                      value: "cash",
                      groupValue: _selectedPayment,
                      activeColor: zelow, // Mengubah warna saat dipilih
                      onChanged: (val) {
                        setState(() {
                          _selectedPayment = val.toString();
                        });
                      },
                    ),
                    title: Text("Cash"),
                  ),
                  ListTile(
                    leading: Radio(
                      value: "card",
                      groupValue: _selectedPayment,
                      activeColor: zelow,
                      onChanged: (val) {
                        setState(() {
                          _selectedPayment = val.toString();
                        });
                      },
                    ),
                    title: Text("Kartu Debit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: () {
 
                Map<String, dynamic> order = {
                  "orderNumber": DateTime.now().millisecondsSinceEpoch,
                  "orderDate": "${DateTime.now().day} ${getMonthName(DateTime.now().month)} ${DateTime.now().year}",
                  "items": List.from(orders),
                };
                
                
                List<Map<String, dynamic>> newOrdersList = [order];
                
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PesananPage(orders: newOrdersList),
                  ),
                );
              },

          style: ElevatedButton.styleFrom(
            backgroundColor: zelow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
