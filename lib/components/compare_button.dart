import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class compareButton extends StatelessWidget{
  final VoidCallback onTap;

  const compareButton({
    super.key,
    required this.onTap,
});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: (){
          onTap();

        },
        child: Container(
            width: 124,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFF06C474),
              border: Border.all(
                color: Color(0xFF06C474),
                width: 1,
              ),
            ),
            child: Center(
              child: Text('Bandingkan', style: TextStyle(fontSize: 16, fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold),),
            )
        ),
      ),
    );

  }
}

