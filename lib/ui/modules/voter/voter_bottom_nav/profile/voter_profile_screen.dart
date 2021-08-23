import 'package:flutter/material.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class VoterProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        SizedBox(
          height: 20,
        ),
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
            text: 'John',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        VotersTextField(
          hintText: 'Last Name',
          labelText: 'Last Name',
          controller: TextEditingController(
            text: 'Doe',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        VotersTextField(
          hintText: 'Email',
          labelText: 'Email',
          controller: TextEditingController(
            text: 'johnn@doe.com',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        VotersTextField(
          hintText: 'Phone Number',
          labelText: 'Phone Number',
          controller: TextEditingController(
            text: '081232728822',
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
          height: 40,
        ),
        VotersOutlinedButton(
          text: 'Logout',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => GetStartedScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
