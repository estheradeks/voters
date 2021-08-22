import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class ElectionCandidateCard extends StatelessWidget {
 const ElectionCandidateCard({
    Key key,
    this.imgUrl,
    this.candidateName,
    this.noOfVotes,
    this.catchPhrase,
    this.onTap,
  }) : super(key: key);

  final String imgUrl;
  final String candidateName;
  final int noOfVotes;
  final String catchPhrase;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
              color: blackColor.withOpacity(.15),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: primaryColor.withOpacity(.3),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esther Adekunle',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Excellence, Moving Forward',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '200 Votes',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
