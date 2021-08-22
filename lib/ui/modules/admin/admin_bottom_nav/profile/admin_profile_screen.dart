import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/models/voter_admin.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key key}) : super(key: key);

  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  VoterAdmin _voterAdmin;

  void _getAdminProfile() async {
    FirebaseFirestore ff = FirebaseFirestore.instance;

    DocumentSnapshot document =
        await ff.collection('admin').doc('8BvyYNbx2AVxfZZXwA9JlB4jOLr1').get();

    _voterAdmin = VoterAdmin.fromJson(
      document.data(),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAdminProfile();
  }

  @override
  Widget build(BuildContext context) {
    return _voterAdmin == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            physics: BouncingScrollPhysics(),
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
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //     _voterAdmin.image,
                  //   ),
                  //   fit: BoxFit.none,
                  // ),
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.network(
                      _voterAdmin.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              VotersTextField(
                hintText: 'First Name',
                labelText: 'First Name',
                controller: TextEditingController(
                  text: _voterAdmin.firstName,
                ),
                readOnly: true,
              ),
              SizedBox(
                height: 15,
              ),
              VotersTextField(
                hintText: 'Last Name',
                labelText: 'Last Name',
                controller: TextEditingController(
                  text: _voterAdmin.lastName,
                ),
                readOnly: true,
              ),
              SizedBox(
                height: 15,
              ),
              VotersTextField(
                hintText: 'Email',
                labelText: 'Email',
                controller: TextEditingController(
                  text: _voterAdmin.email,
                ),
                readOnly: true,
              ),
              SizedBox(
                height: 15,
              ),
              VotersTextField(
                hintText: 'Phone Number',
                labelText: 'Phone Number',
                controller: TextEditingController(
                  text: _voterAdmin.phoneNumber,
                ),
                readOnly: true,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
              ),
              VotersOutlinedButton(
                text: 'Logout',
                onPressed: () async {
                  StorageService storageService = StorageService();
                  await storageService.removeAddress();
                  await storageService.removePrivateKey();
                  await storageService.removeRole();
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
