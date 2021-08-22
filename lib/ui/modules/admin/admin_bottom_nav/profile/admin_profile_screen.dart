import 'package:flutter/material.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
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
          height: 10,
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
