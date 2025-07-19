import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/order_item_card.dart';
import 'package:zelow/pages/user/pesanan_page.dart';
import 'package:zelow/services/pesanan_service.dart';

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
  String _selectedTab = "Pick Up";
  String _selectedSchedule = "12:00 - 13:00";

  final currencyFormatter = NumberFormat("#,##0", "id_ID");

  String formatRupiah(num value) {
    return "Rp${currencyFormatter.format(value)}";
  }

  // Backend service checkout
  final PesananService _pesananService = PesananService();
  bool _isProcessing = false;

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garis drag indikator
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Tab Switcher
                    Row(
                      children: [
                        _buildTabButton(
                          "Pick Up",
                          _selectedTab,
                          zelow,
                          setModalState,
                        ),
                        SizedBox(width: 12),
                        _buildTabButton(
                          "Delivery",
                          _selectedTab,
                          zelow,
                          setModalState,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    if (_selectedTab == "Pick Up") ...[
                      Text(
                        "Ambil Langsung ke Toko",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Langsung ambil belanjaanmu tanpa perlu menunggu",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Toko Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.store, color: zelow),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nama Toko
                                Text(
                                  widget.orders.isNotEmpty &&
                                          widget.orders[0]["nama"] != null
                                      ? widget.orders[0]["nama"]
                                      : "-",
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),

                                // Alamat Toko
                                Text(
                                  widget.orders.isNotEmpty &&
                                          widget.orders[0]["alamat"] != null
                                      ? widget.orders[0]["alamat"]
                                      : "-",
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),

                                Text(
                                  "Buka 07.00 - 23.00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                SizedBox(height: 8),

                                GestureDetector(
                                  onTap: () {
                                    // Navigasi ke detail toko
                                  },
                                  child: Text(
                                    "Informasi Toko",
                                    style: TextStyle(
                                      color: zelow,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Jadwal
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jadwal Pengambilan",
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Pilih Jadwal yang Tersedia",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito',
                              ),
                            ),

                            Divider(height: 20),

                            Text(
                              "Hari Ini",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Text(
                              DateFormat(
                                "d MMMM yyyy",
                                'id_ID',
                              ).format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            SizedBox(height: 4),

                            Column(
                              children: [
                                _buildScheduleRadio(
                                  "12:00 - 13:00",
                                  _selectedSchedule,
                                  zelow,
                                  setModalState,
                                ),
                                _buildScheduleRadio(
                                  "18:00 - 19:00",
                                  _selectedSchedule,
                                  zelow,
                                  setModalState,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 190),
                      Center(
                        child: Text(
                          "Segera Hadir...",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Colors.grey
                          ),
                        ),
                      ),
                      SizedBox(height: 190),
                    ],
                    SizedBox(height: 36),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: zelow,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(
                          "Terapkan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTabButton(
    String label,
    String selected,
    Color color,
    void Function(void Function()) setModalState,
  ) {
    final isSelected = label == selected;
    return Expanded(
      child: InkWell(
        onTap: () => setModalState(() => _selectedTab = label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleRadio(
    String value,
    String groupValue,
    Color color,
    void Function(void Function()) setModalState,
  ) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          activeColor: color,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (val) {
            setModalState(() {
              _selectedSchedule = val.toString();
            });
          },
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  double get harga {
    return orders.fold(
      0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: BackButton(color: white),
        backgroundColor: zelow,
        iconTheme: IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat Resto",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.orders.isNotEmpty && widget.orders[0]["alamat"] != null
                    ? widget.orders[0]["alamat"]
                    : "-",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Tipe Pemesanan",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(14),
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
                      Text(
                        "Pilih Tipe Pemesanan",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18, color: zelow),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Rincian Pesanan",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                "Ringkasan Pembayaran",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris Harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Harga",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          formatRupiah(
                            harga,
                          ), // ganti dengan nilai harga sebenarnya
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Baris Biaya Layanan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Biaya Layanan",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          formatRupiah(serviceFee),
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(),

                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatRupiah(harga + serviceFee),
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // tampilkan modal atau navigasi ke halaman voucher
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mau pakai voucher?",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18, color: zelow),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mau pakai metode bayar apa?",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Radio(
                          value: "cash",
                          groupValue: _selectedPayment,
                          activeColor: zelow,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (val) {
                            setState(() {
                              _selectedPayment = val.toString();
                            });
                          },
                        ),
                        Text(
                          "Cash",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "card",
                          groupValue: _selectedPayment,
                          activeColor: zelow,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (val) {
                            setState(() {
                              _selectedPayment = val.toString();
                            });
                          },
                        ),
                        Text(
                          "Kartu Debit",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(bottom: 24, left: 18, right: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Map<String, dynamic> order = {
                  "orderNumber": DateTime.now().millisecondsSinceEpoch,
                  "orderDate":
                      "${DateTime.now().day} ${getMonthName(DateTime.now().month)} ${DateTime.now().year}",
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
