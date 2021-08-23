import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/voter_admin.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class CreateElectionScreen extends StatefulWidget {
  const CreateElectionScreen({Key key}) : super(key: key);

  @override
  _CreateElectionScreenState createState() => _CreateElectionScreenState();
}

class _CreateElectionScreenState extends State<CreateElectionScreen> {
  String _electionTitle = '';
  String _electionDescription = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
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
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/voters-87247.appspot.com/o/voting.jpeg?alt=media&token=a80e0bd1-053a-4a9c-8cb7-702604f8ad4c',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                VotersTextField(
                  hintText: 'Election Title',
                  labelText: 'Election Title',
                  onChanged: (val) {
                    setState(() {
                      _electionTitle = val;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Election Description',
                  labelText: 'Election Description',
                  onChanged: (val) {
                    setState(() {
                      _electionDescription = val;
                    });
                  },
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
            text: 'Create Election'.toUpperCase(),
            onPressed: () async {
              showLoadingDialog(context);
              FirebaseFirestore ff = FirebaseFirestore.instance;

              DocumentSnapshot document = await ff
                  .collection('admin')
                  .doc('8BvyYNbx2AVxfZZXwA9JlB4jOLr1')
                  .get();

              final voterAdmin = VoterAdmin.fromJson(
                document.data(),
              );
              var result = await electionService.writeContract(
                electionService.setElectionDetails,
                [
                  voterAdmin.firstName + ' ' + voterAdmin.lastName,
                  voterAdmin.email,
                  'Administrator',
                  _electionTitle,
                  _electionDescription,
                ],
              );

              Navigator.pop(context);

              Navigator.pop(context, result);
            },
          ),
        ],
      ),
    );
  }
}
