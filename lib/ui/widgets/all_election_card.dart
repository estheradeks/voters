import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class AllElectionCard extends StatelessWidget {
  const AllElectionCard({
    Key key,
    this.onTap,
  }) : super(key: key);

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
                color: primaryColor.withOpacity(.4),
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
                  'Governorship Election',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '20 Positions',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '23rd November, 2020',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
