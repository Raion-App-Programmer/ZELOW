import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/user/home_page_user.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

final FocusNode _focusNode = FocusNode();

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Perbarui UI saat fokus berubah
    });
  }

  // @override
  // void dispose() {
  //   _focusNode.dispose(); // Penting untuk menghindari memory leak
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 133,
        leading: BackButton(),
        title: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              hintText: 'Lagi pengen makan apa?',
              prefixIcon: Icon(Icons.search),
              prefixIconColor:
                  _focusNode.hasFocus ? Colors.grey : Colors.black12,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
            onEditingComplete: (){
              // Navigator.push(
              //context,
              // MaterialPageRoute(builder: (context) =>));
            },
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: HomePageUser.previousSearchs.length,
                itemBuilder: (context, index) => previousSearchsItem(index),
              ),
            ),

            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Suggestion'),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      searchSuggestionItem('Ayam goreng'),
                      searchSuggestionItem('Sushi'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      searchSuggestionItem('Ayam Hytam'),
                      searchSuggestionItem('Hiu bakar'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

previousSearchsItem(int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: InkWell(
      onTap: () {},
      child: Dismissible(
        key: GlobalKey(),
        onDismissed: (DismissDirection dir) {
          HomePageUser.previousSearchs.removeAt(index);
        },
        child: Row(
          children: [
            const Icon(Icons.timelapse_sharp, color: Colors.grey),
            const SizedBox(width: 10),
            Text(
              HomePageUser.previousSearchs[index],
              selectionColor: Colors.black26,
            ),
            Spacer(),
            Icon(Icons.cancel_outlined, color: Colors.grey.shade500),
          ],
        ),
      ),
    ),
  );
}

searchSuggestionItem(String text) {
  return Container(
    margin: EdgeInsets.only(left: 8),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    color: Colors.grey.shade50,
    child: Text(text, style: TextStyle(color: Colors.grey)),
  );
}
