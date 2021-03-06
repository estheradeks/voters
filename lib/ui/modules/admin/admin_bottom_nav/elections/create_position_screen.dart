import 'package:flutter/material.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class CreatePositionScreen extends StatelessWidget {
  const CreatePositionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.close_rounded,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor.withOpacity(.5),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Governorship Election',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF62961D),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                VotersTextField(
                  hintText: 'Position Name',
                  labelText: 'Position Name',
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Position Description',
                  labelText: 'Position Description',
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   height: 75,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5.0),
          //     color: blackColor,
          //   ),
          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Center(
          //     child: Text.rich(
          //       TextSpan(
          //         text: 'You are about to vote for ',
          //         style: TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.w600,
          //           color: whiteColor,
          //           height: 1.5,
          //         ),
          //         children: [
          //           TextSpan(
          //             text: 'Esther Adekunle',
          //             style: TextStyle(
          //               color: primaryColor,
          //             ),
          //           ),
          //           TextSpan(
          //             text: ' for the position ',
          //           ),
          //           TextSpan(
          //             text: 'President',
          //             style: TextStyle(
          //               color: primaryColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          VotersFilledButton(
            text: 'Create Position',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
