import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? nameController;
  String selectedGender = 'Perempuan'; // default
  final List<String> genderOptions = ['Perempuan', 'Laki-laki'];
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    nameController = TextEditingController(text: user?.displayName ?? '');
  }

  @override
  void dispose() {
    nameController?.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2101), // Latest date
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = "${picked.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: whiteTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ), 
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              // TODO: Implement save logic
              print('All changes saved!');
            }, 
            child: GestureDetector(
              onTap: () {
                // TODO: implement save function
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: 353,
                      height: 75,
                      child: AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          'Perubahan telah disimpan',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                );
              },
              child: Text(
                'Simpan',
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                children: [
                  Center( // for the container
                    child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff06C474),
                                  width: 1,
                                )
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.1,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/user.png'),
                                  backgroundColor: Color(0xffE6F9F1),
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Input Text Here', 
                    contentPadding: EdgeInsets.only(left: 16),
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 9,),
                Text(
                  'Jenis Kelamin',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8,),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender, 
                      child: Text(
                        gender, 
                        style: greyTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ), 
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none, 
                    ),
                    filled: true,
                    fillColor: Color(0xffEFEFEF),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  'Tanggal Lahir',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 353,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0XffEFEFEF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate.isEmpty ? 'Input Date Here' : selectedDate,
                            style: greyTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.asset('assets/images/solar_calendar-bold.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
