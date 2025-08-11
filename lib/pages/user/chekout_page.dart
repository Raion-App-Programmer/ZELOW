import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/order_item_card.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/pages/user/payment_option_page.dart';
import 'package:zelow/services/toko_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const CheckoutPage({super.key, required this.orders});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TokoServices _tokoService = TokoServices();

  late Set<String> alamatOrders;
  late List<Map<String, dynamic>> orders;

  double serviceFee = 4900.0;
  String _selectedPayment = "transfer";
  String _selectedTab = "Pick Up";
  bool _isOrderTypeSelected = false;

  late String _selectedSchedule;
  late List<String> schedules;

  final currencyFormatter = NumberFormat("#,##0", "id_ID");

  String formatRupiah(num value) {
    return "Rp${currencyFormatter.format(value)}";
  }

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

  List<String> getScheduleSlots() {
    final openHour = 8;
    final closeHour = 21;

    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;

    List<String> slots = [];

    if (hour >= closeHour) {
      slots.add(
        "${openHour.toString().padLeft(2, '0')}:00 - ${(openHour + 1).toString().padLeft(2, '0')}:00",
      );
      slots.add(
        "${(openHour + 1).toString().padLeft(2, '0')}:00 - ${(openHour + 2).toString().padLeft(2, '0')}:00",
      );
      return slots;
    }

    int startHour;
    if (minute <= 30) {
      startHour = hour;
    } else {
      startHour = hour + 1;
    }

    for (int i = 0; i < 2; i++) {
      int fromHour = (startHour + i);
      int toHour = fromHour + 1;

      if (fromHour >= closeHour) {
        fromHour = openHour + ((fromHour - closeHour) % (closeHour - openHour));
        toHour = fromHour + 1;
      }

      slots.add(
        "${fromHour.toString().padLeft(2, '0')}:00 - ${toHour.toString().padLeft(2, '0')}:00",
      );
    }

    return slots;
  }

  String getDefaultSchedule() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    final List<String> slots = [
      "08:00 - 09:00",
      "09:00 - 10:00",
      "10:00 - 11:00",
      "11:00 - 12:00",
      "12:00 - 13:00",
      "13:00 - 14:00",
      "14:00 - 15:00",
      "15:00 - 16:00",
      "16:00 - 17:00",
      "17:00 - 18:00",
      "18:00 - 19:00",
      "19:00 - 20:00",
      "20:00 - 21:00",
      "21:00 - 22:00",
    ];

    int index;
    if (minute < 30) {
      index = slots.indexWhere(
        (slot) => slot.startsWith("${hour.toString().padLeft(2, '0')}:"),
      );
    } else {
      // Skip ke slot berikutnya
      index = slots.indexWhere(
        (slot) => slot.startsWith("${(hour + 1).toString().padLeft(2, '0')}:"),
      );
    }

    if (index == -1) {
      index = 0;
    }

    return slots[index];
  }

  @override
  void initState() {
    super.initState();
    schedules = getScheduleSlots();
    _selectedSchedule = getDefaultSchedule();

    orders = List.from(widget.orders);
    alamatOrders =
        widget.orders.map((order) => order['alamat'].toString()).toSet();
  }

  void _increaseQuantity(int index) {
    final order = orders[index];
    final int stok = order['stok'] ?? 0;
    final int terjual = order['terjual'] ?? 0;
    final bool isFlashSale = order['isFlashSale'] ?? false;
    final int quantity = order['quantity'] ?? 0;

    int stokTersisa = stok - terjual;
    int maxPembelian = isFlashSale ? 2 : stokTersisa;

    if (quantity >= maxPembelian) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                isFlashSale
                    ? 'Pembelian flash sale maksimal 2 item'
                    : 'Pembelian mencapai batas maksimum stok',
              ),
              backgroundColor: zelow,
              duration: const Duration(seconds: 1),
            ),
          );
      }
      return;
    }

    setState(() {
      orders[index]['quantity'] = quantity + 1;
    });
  }

  void _decreaseQuantity(int index) {
    if (orders[index]['quantity'] > 1) {
      setState(() {
        orders[index]['quantity']--;
      });
    }
  }

  // Ini nampilin alamat toko yang diambil dari variable alamatOrders
  // Jika hanya ada satu alamat, tampilkan sebagai teks biasa aja
  // Jika ada lebih dari satu alamat, tampilkan sebagai daftar dengan bullet points
  Widget buildAlamatToko(Set<String> alamatOrders) {
    if (alamatOrders.length == 1) {
      return Text(
        alamatOrders.first,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          color: Colors.grey.shade700,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final alamat in alamatOrders)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "•  ",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: Colors.grey.shade800,
                  ),
                ),
                Expanded(
                  child: Text(
                    alamat,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    }
  }

  Widget buildTokoInfo(Set<Map<String, String>> tokoOrders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          tokoOrders.map((toko) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.store, color: zelow),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          toko['nama'] ?? '-',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          toko['alamat'] ?? '-',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Buka 08.00 - 21.00",
                          style: TextStyle(fontSize: 14, fontFamily: 'Nunito'),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final tokoDetail = await _tokoService.getTokoById(
                              toko['idToko'] ?? '',
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        TokoPageUser(tokoData: tokoDetail),
                              ),
                            );
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
            );
          }).toList(),
    );
  }

  void _showOrderTypeModal(BuildContext context) {
    final tokoOrders = <Map<String, String>>{};

    for (var order in widget.orders) {
      final idToko = order['idToko']?.toString() ?? '';
      final nama = order['nama']?.toString() ?? '-';
      final alamat = order['alamat']?.toString() ?? '-';

      final sudahAda = tokoOrders.any((t) => t['idToko'] == idToko);

      if (!sudahAda) {
        tokoOrders.add({'idToko': idToko, 'nama': nama, 'alamat': alamat});
      }
    }

    final now = DateTime.now();
    final isTutup = now.hour >= 21;
    final tanggalBesok = now.add(Duration(days: 1));

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
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Padding(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
                          SizedBox(height: 16),

                          buildTokoInfo(tokoOrders),
                          SizedBox(height: 4),

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
                                  isTutup
                                      ? "Toko Tutup, Ambil Besok"
                                      : "Hari Ini",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    "d MMMM yyyy",
                                    'id_ID',
                                  ).format(isTutup ? tanggalBesok : now),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                SizedBox(height: 4),

                                Column(
                                  children:
                                      schedules.map((time) {
                                        return _buildScheduleRadio(
                                          time,
                                          _selectedSchedule,
                                          zelow,
                                          setModalState,
                                        );
                                      }).toList(),
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
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 190),
                        ],
                        SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isOrderTypeSelected = true;
                                _selectedTab = "Pick Up";
                                _selectedSchedule = _selectedSchedule;
                              });
                              Navigator.pop(context);
                            },
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
              buildAlamatToko(alamatOrders),
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
                        !_isOrderTypeSelected
                            ? "Pilih Tipe Pemesanan"
                            : "$_selectedTab $_selectedSchedule",
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
                        gambar: item['imageUrl'],
                        nama: item['title'],
                        harga: item['price'],
                        hargaAsli: item['originalPrice'],
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
                          value: "transfer",
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
                          "Transfer Bank",
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
                if (!_isOrderTypeSelected) {
                  _showOrderTypeModal(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PaymentOptionPage(
                            orders: orders,
                            subtotal: harga + serviceFee,
                            selectedPayment: _selectedPayment,
                            selectedSchedule: _selectedSchedule,
                          ),
                    ),
                  );
                }
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
              child: Text(
                _isOrderTypeSelected ? "Checkout" : "Pilih Tipe Pemesanan",
                style: const TextStyle(
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
