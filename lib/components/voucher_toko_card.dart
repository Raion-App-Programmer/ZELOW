//

import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class VoucherTokoCard extends StatefulWidget {
  const VoucherTokoCard({super.key});

  @override
  _VoucherTokoCardState createState() => _VoucherTokoCardState();
}

class _VoucherTokoCardState extends State<VoucherTokoCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Container(
            height: 70,
            width: 180,
            decoration: BoxDecoration(
              color: Color(0xFF06C474),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 160,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  VerticalDivider(thickness: 1, color: Colors.white),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Cashback 20%',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '1 sd 2rb',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'S&K',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'nunito',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                            SizedBox(width: 24),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 50,
                              height: 14,
                              child: Center(
                                child: Text(
                                  'Klaim',
                                  style: TextStyle(
                                    fontFamily: 'nunito',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: zelow,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
