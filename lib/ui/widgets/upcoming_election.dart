import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class UpcomingElectionCard extends StatelessWidget {
  const UpcomingElectionCard({
    Key key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

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
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Presidential Election',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '20 Positions',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Text(
                '19th November, 2020',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
