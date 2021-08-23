import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class UpcomingElectionCard extends StatelessWidget {
  const UpcomingElectionCard({
    Key key,
    this.onTap,
    this.electionName,
  }) : super(key: key);

  final VoidCallback onTap;
  final String electionName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 250,
        width: 200,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  color: primaryColor.withOpacity(.4),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/voters-87247.appspot.com/o/voting.jpeg?alt=media&token=a80e0bd1-053a-4a9c-8cb7-702604f8ad4c',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                electionName,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.0),
            //   child: Text(
            //     'Click to view more',
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Text(
                'Click to view more',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
