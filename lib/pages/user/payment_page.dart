import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), 
        child: SafeArea(
          child: AppBar(
            leading: BackButton(),
            centerTitle: true,
            title: Text("Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            ),
          ),
         ),
      body: Padding(padding: EdgeInsets.only(left: 16,right: 16, top: 24, bottom: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: AlignmentDirectional.topCenter,
            width: 361,
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffE6F9F1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 7)
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                Text("Total Price", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                Text("Rp 400.000", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                SizedBox(height: 14),
                Text("Account Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text("4216578890", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                TextButton(
                  onPressed: (){

                  },
                child: Text("Copy Code", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400), selectionColor: Colors.black))
              ],
            ),
          ),
          SizedBox(height: 19),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("How to Pay", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text("1. Go to your bank account\n2. Clik “Transfer”", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Text.rich(
                  TextSpan(
                    text: "3. Choose ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "Mandiri",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)
                      ),
                      TextSpan(
                        text: " Bank",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    text: "4. Input the account number ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "4216578890",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)
                      ),
                      TextSpan(
                        text: " or copy the account number",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)
                      ),
                    ]
                  )),
                Text("5. Enter the amount of the transfer\n6. Make sure the information is correct\n7. Confirm by entering your password\n8. Payment is successful", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),

              ],
              )
            ),
            Spacer(),
            SizedBox(
              height: 44,
              width: 353,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff06C474),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24  )
                  )
                ),
               child: Text("Saya Sudah Membayar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white))),
            )
        ],
      )
      
    )
    );
  }
}