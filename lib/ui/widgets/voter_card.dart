import 'package:flutter/material.dart';
import 'package:voters/core/models/voter.dart';
import 'package:voters/utils/theme.dart';

class VotersCard extends StatelessWidget {
  const VotersCard({
    Key key,
    this.voter,
    this.onTap,
    this.positionSN,
  }) : super(key: key);

  final int positionSN;
  final Voter voter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 105,
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
              child: Center(
                child: Text(
                  '$positionSN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
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
                  voter.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  voter.phone,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Verified: ${voter.isVerified == true ? 'YES' : 'NO'}',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Voted: ${voter.hasVoted == true ? 'YES' : 'NO'}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
