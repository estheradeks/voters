import 'package:flutter/material.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class CandidateDetailsBottomSheet extends StatelessWidget {
  const CandidateDetailsBottomSheet({
    Key key,
    this.isAdmin = false,
  }) : super(key: key);

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(.5),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                VotersTextField(
                  hintText: 'First Name',
                  labelText: 'First Name',
                  controller: TextEditingController(
                    text: 'Esther',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                  controller: TextEditingController(
                    text: 'Adekunle',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Email',
                  labelText: 'Email',
                  controller: TextEditingController(
                    text: 'estheradekunle@gmail.com',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  controller: TextEditingController(
                    text: '08143037721',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Gender',
                  labelText: 'Gender',
                  controller: TextEditingController(
                    text: 'Male',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Date of Birth',
                  labelText: 'Date of Birth',
                  controller: TextEditingController(
                    text: '00/00/0000',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'State',
                  labelText: 'State',
                  controller: TextEditingController(
                    text: 'Osun State',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'LGA',
                  labelText: 'LGA',
                  controller: TextEditingController(
                    text: 'Lagelu LGA',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          if (!isAdmin)
            SizedBox(
              height: 10,
            ),
          if (!isAdmin)
            Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: blackColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'You are about to vote for ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Esther Adekunle',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' for the position ',
                      ),
                      TextSpan(
                        text: 'President',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!isAdmin)
            SizedBox(
              height: 20,
            ),
          if (!isAdmin)
            VotersFilledButton(
              text: 'Vote Esther Adekunle',
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}