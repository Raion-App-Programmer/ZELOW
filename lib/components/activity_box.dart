import 'package:flutter/material.dart';

class activtyBox extends StatelessWidget {
  final bool isEmpty;
  //final VoidCallback onTap;
  
  const activtyBox({
    super.key,
    this.isEmpty = true,
    //required this.onTap
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      isEmpty?
          Center(
            child:
            Column(
              children: [
                SizedBox(height: 120,),
                Image.asset(
                  'assets/images/empty_activity.png',
                  width: 216,
                  height: 210,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text('Tidak Ditemukan', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito', fontSize: 20),),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text('Kamu belum melakukan penarikan saldo nihh..', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Nunito', color: Color(0xFF8A8A8A))),
                  ],
          )
      
      ): Column()
    );
  }
}