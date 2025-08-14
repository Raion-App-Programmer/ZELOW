import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/income_information.dart';

import '../../components/activity_box.dart';

class IncomeReport extends StatefulWidget {
  @override
  _IncomeReportState createState() => _IncomeReportState();
}

class _IncomeReportState extends State<IncomeReport> {
  List<bool> _isSelect = [true, false];
  String _selectedButton = 'Pendapatan';

  @override
  Widget build(BuildContext context) {
    Widget currentContent;
    if (_selectedButton == 'Pendapatan') {
      currentContent = incomeInformation();
    } else {
      currentContent = activtyBox();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home_page_umkm');
          },
        ),
        title: Text(
          'Laporan',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            selectButton(),
            SizedBox(height: 12),
            currentContent,
          ],
        ),
      ),
    );
  }

  Widget selectButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFE6F9F1),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(20),
        constraints: BoxConstraints(minHeight: 40, minWidth: 174),
        isSelected: _isSelect,
        color: Color(0xFF06C474),
        selectedColor: Colors.white,
        fillColor: Color(0xFF06C474),
        renderBorder: false,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Pendapatan',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Aktivitas',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        onPressed: (int newIndex) {
          setState(() {
            for (int index = 0; index < _isSelect.length; index++) {
              _isSelect[index] = index == newIndex;
            }

            _selectedButton =
                (newIndex == 0) ? 'Pendapatan' : 'Aktivitas';
          });
        },
      ),
    );
  }
}
