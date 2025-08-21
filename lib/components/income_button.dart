import 'package:flutter/material.dart';
import 'package:zelow/components/card_income.dart';
import 'package:zelow/components/compare_button.dart';
import 'package:zelow/components/constant.dart';

class incomeButton extends StatelessWidget{
  final bool isSelectDay;
  final VoidCallback onTapDay;
  final VoidCallback onTapWeek;
  final bool isSelectWeek;

  const incomeButton({
    super.key,
    required this.isSelectDay,
    required this.isSelectWeek,
    required this.onTapDay,
    required this.onTapWeek,
  }
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: (){
              onTapDay();
            },
            child:
            Container(
              width: 80,
              height: 28,
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isSelectDay?Color(0xFF06C474) : Colors.transparent,
                border: Border.all(
                  color: isSelectDay?Colors.transparent: Color(0xFFB8B8B8),
                  width: 1,
                ),
              ),
              child: Center(
                child:Text('Hari Ini', style: TextStyle(fontSize: 12, fontFamily: 'Nunito', color: isSelectDay?Colors.white: Color(0xFFB8B8B8), fontWeight: FontWeight.bold), textAlign: TextAlign.center,) ,
              ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 35)),

        Material(
            color: Colors.transparent,
            child: InkWell(
            borderRadius: BorderRadius.circular(24),
        onTap: (){
              onTapWeek();
        }, child:
        Container(
          width: 100,
          height: 28,
          decoration:
          BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: isSelectWeek?Color(0xFF06C474) : Colors.transparent,
            border: Border.all(
              color: isSelectWeek?Colors.transparent: Color(0xFFB8B8B8),
              width: 1,
            ),
          ),
          child: Center(
            child:Text('Satu Minggu', style: TextStyle(fontSize: 12, fontFamily: 'Nunito', color: isSelectWeek?Colors.white: Color(0xFFB8B8B8), fontWeight: FontWeight.bold), textAlign: TextAlign.center,) ,
          )


        ),
    )
        )
        ]
    );
  }

}