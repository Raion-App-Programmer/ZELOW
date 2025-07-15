import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/compare_button.dart';
import 'card_income.dart';

class incomeInformation extends StatefulWidget {
  const incomeInformation({super.key});

  @override
  State<incomeInformation> createState() => _incomeInformationState();
}

class _incomeInformationState extends State<incomeInformation> {
  Map<String, dynamic> incomeDay = {
    'title': 'Pendapatan Hari ini',
    'qris': 1000000,
    'other': 500000,
    'layanan': 69000,
    'pajak': 666000,
   // 'displayDate': DateTime.now()
  };

  Map<String, dynamic> incomeWeek = {
    'title': 'Pendapatan Minggu ini',
    'qris': 1020000,
    'other': 500000,
    'layanan': 69200,
    'pajak': 663000,
    //'displayDate' : DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1))
  };

  Map<String, dynamic> incomeTwoDaysAgo = {
    'title': 'Pendapatan 2 hari lalu',
    'qris': 80000,
    'other': 90000,
    'layanan': 69000,
    'pajak': 60800,
    //'displayDate' : DateTime.now().subtract(Duration(days: 2))
  };

  Map<String, dynamic> incomeWeekAgo = {
    'title': 'Pendapatan 2 minggu lalu',
    'qris': 1200000,
    'other': 540000,
    'layanan': 109000,
    'pajak': 61000,
    //'displayDate': DateTime.now().subtract(Duration(days: 14))
  };

  bool isSelectMenuDay = true;
  bool isCompare = false;

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();
    DateTime twoDaysAgoDate = todayDate.subtract(Duration(days: 2));
    DateTime startOfWeekDate = todayDate.subtract(Duration(days: todayDate.weekday - 1)); // Menghitung Senin minggu ini
    DateTime twoWeeksAgoDate = todayDate.subtract(Duration(days: 14));

    final currentData = isSelectMenuDay ? incomeDay : incomeWeek;
    final previousData = isSelectMenuDay ? incomeTwoDaysAgo : incomeWeekAgo;

    DateTime currentDisplayDate = isSelectMenuDay ? todayDate : startOfWeekDate;
    DateTime previousDisplayDate = isSelectMenuDay ? twoDaysAgoDate : twoWeeksAgoDate;

    int currentTotal = currentData['qris'] + currentData['other'] - currentData['layanan'] - currentData['pajak'];
    int previousTotal = previousData['qris'] + previousData['other'] - previousData['layanan'] - previousData['pajak'];
    
    Color currentColor = Colors.black;
    Color previousColor = Colors.black;

    String? currentIcon;
    String? previousIcon;

    if(isCompare){
      if(currentTotal > previousTotal){
        currentColor = Color(0xFF06C474);
        previousColor = Color(0xFFF1323E);
        currentIcon = 'assets/images/up-arrow.png';
        previousIcon = 'assets/images/down-arrow.png';

      } else if(currentTotal < previousTotal){
        currentColor = Color(0xFFF1323E);
        previousColor = Color(0xFF06C474);
        currentIcon = 'assets/images/down-arrow.png';
        previousIcon = 'assets/images/up-arrow.png';
      } else {
        currentColor = Colors.black;
        previousColor = Colors.black;
        currentIcon = null;
        previousIcon = null;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Ringkasan',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children:  [
              Text(
                'Terakhir diperbarui pada, ',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFF676767),
                ),
              ),
              dateInformation(showTime: true),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              choiceButton(
                text: "Hari Ini",
                selected: isSelectMenuDay,
                onTap: () {
                  setState(() => isSelectMenuDay = true);
                },
              ),
              const SizedBox(width: 8),
              choiceButton(
                text: "Satu Minggu",
                selected: !isSelectMenuDay,
                onTap: () {
                  setState(() => isSelectMenuDay = false);
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          cardIncome(
            title: currentData['title'],
            qris: currentData['qris'],
            other: currentData['other'],
            layanan: currentData['layanan'],
            pajak: currentData['pajak'],
            displayDate: currentDisplayDate,
            totalColor: currentColor,
            icon: currentIcon,
          ),
          const SizedBox(height: 18),
          Center(
            child:
            compareButton(
                onTap: (){
                  if(isSelectMenuDay == true){
                    setState(() {
                      isCompare = !isCompare;
                    }
                    );
                  } else {
                    setState(() {
                      isCompare = !isCompare;
                    });
                  }

                }
            ),
          ),
          const SizedBox(height: 18),
          cardIncome(
            title: previousData['title'],
            qris: previousData['qris'],
            other: previousData['other'],
            layanan: previousData['layanan'],
            pajak: previousData['pajak'],
            displayDate: previousDisplayDate,
            totalColor: previousColor,
            icon: previousIcon,
          )
        ],
      )

    );

  }

  Widget choiceButton({
    required String text,
    required bool selected,
    required VoidCallback onTap
  })
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF06C474) : const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: selected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}


class dateInformation extends StatefulWidget {
  final bool showTime;
  final DateTime? displayDate;

  const dateInformation({
    super.key,
    this.showTime = true,
    this.displayDate,
});


  @override
  State<dateInformation> createState() => _dateInformationState();
}

class _dateInformationState extends State<dateInformation> {
  String tanggal = '';

  @override
  void initState() {
    super.initState();
    updateDate();
  }

  @override
  void didUpdateWidget(covariant dateInformation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.displayDate != oldWidget.displayDate || widget.showTime != oldWidget.showTime) {
      updateDate();
    }
  }

  void updateDate() {
    final date = DateTime.now();
    String formatPatternCard;
    DateTime dateToFormat = widget.displayDate ?? DateTime.now();
    if (widget.showTime) {
      formatPatternCard = 'dd MMMM yyyy HH:mm';
    } else {
      formatPatternCard = 'dd MMMM yyyy';
    }
    //final formatPattern = widget.showTime ? 'dd MMMM yyyy HH:mm' : 'dd MMMM yyyy';
    setState(() {
      tanggal = DateFormat(formatPatternCard).format(dateToFormat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      tanggal,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xFF676767),
      ),
    );
  }
}
