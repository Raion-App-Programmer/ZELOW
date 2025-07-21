import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:zelow/components/rating_review_user.dart';

class UserReview extends StatefulWidget {
  final Image profil;
  final String name;
  final String review;
  final double valuerate;
  const UserReview({
    super.key,
    required this.profil,
    required this.name,
    required this.review,
    required this.valuerate,
  });

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Container(width: MediaQuery.of(context).size.width * 1, height: 1.5, color: Color(0xFFADADAD)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.024),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(height: 40, width: 40, child: widget.profil),
                    
                  SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.28,
                    ),
                    child: Text(
                      widget.name,
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
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
              child: RatingReviewUser(rating: widget.valuerate),
            ),
          ],
        ),
    
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width * 0.105),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadMoreText(
                widget.review,
                trimMode: TrimMode.Line,
                trimLines: 1,
                trimCollapsedText: ' more',
                trimExpandedText: ' less',
                moreStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF06C474)),
                lessStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF06C474)),
              ),
    
              
            ],
          ),
        ),
    
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text('2 hari lalu', style: TextStyle(fontSize: 8, color: Color(0xFF676767), fontWeight: FontWeight.normal),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.024),
      ],
    );
  }
}
