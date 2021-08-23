import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class ElectionPositionCard extends StatelessWidget {
  const ElectionPositionCard({
    Key key,
    this.positionSN,
    this.positionName,
    this.slogan,
    this.onTap,
  }) : super(key: key);

  final int positionSN;
  final String positionName;
  final String slogan;
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
                  positionName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  slogan,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
