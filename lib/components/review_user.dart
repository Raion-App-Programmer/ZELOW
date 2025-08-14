import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:zelow/components/rating_review_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserReview extends StatefulWidget {
  const UserReview({super.key});

  @override
  State<UserReview> createState() => _UserReviewState();
}
final Stream<QuerySnapshot> usersReview =
    FirebaseFirestore.instance
        .collection('produk')
        .doc('5oKV3FMZp3vP4DmLWObz')
        .collection('ulasan')
        .orderBy('tanggal', descending: true)
        .snapshots();

class _UserReviewState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersReview,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("Belum ada ulasan"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot docs = snapshot.data!.docs[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 1.5,
                  color: Color(0xFFADADAD),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Image( 
                              //DUMMY IMAGE PROFILE
                              image: AssetImage('assets/images/Mask_group.png'),
                            ),
                          ),

                          SizedBox(width: 8),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.28,
                            ),
                            child: Text(
                              docs['fullname'], //USERNAME
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: RatingReviewUser(
                        rating: docs['rating'],
                      ), //RATING VALUE
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.105,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReadMoreText(
                        docs['komentar'], //REVIEW
                        trimMode: TrimMode.Line,
                        trimLines: 1,
                        trimCollapsedText: ' more',
                        trimExpandedText: ' less',
                        moreStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06C474),
                        ),
                        lessStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06C474),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                //WAKTU UP REVIEW NYA
                Text(
                  DateFormat(
                    'dd MMMM yyyy',
                  ).format((docs['tanggal'] as Timestamp).toDate()),
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF676767),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.024),
              ],
            );
          },
        );
      },
    );
  }
}
