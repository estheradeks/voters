import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/candidate.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class CreateCandidateScreen extends StatefulWidget {
  @override
  _CreateCandidateScreenState createState() => _CreateCandidateScreenState();
}

class _CreateCandidateScreenState extends State<CreateCandidateScreen> {
  String _candidateName = '';

  String _candidateSlogan = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.9,
      height: 500,
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
                  hintText: 'Candidate Name',
                  labelText: 'Candidate Name',
                  onChanged: (val) {
                    setState(() {
                      _candidateName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                VotersTextField(
                  hintText: 'Candidate Slogan',
                  labelText: 'Candidate Slogan',
                  onChanged: (val) {
                    setState(() {
                      _candidateSlogan = val;
                    });
                  },
                ),
                // VotersTextField(
                //   hintText: 'First Name',
                //   labelText: 'First Name',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'Last Name',
                //   labelText: 'Last Name',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'Email',
                //   labelText: 'Email',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'Phone Number',
                //   labelText: 'Phone Number',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'Gender',
                //   labelText: 'Gender',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'Date of Birth',
                //   labelText: 'Date of Birth',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'State',
                //   labelText: 'State',
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // VotersTextField(
                //   hintText: 'LGA',
                //   labelText: 'LGA',
                // ),
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
            text: 'Create Candidate'.toUpperCase(),
            onPressed: () async {
              showLoadingDialog(context);
              String _privakeKey = await StorageService().getPrivateKey();
              ElectionService electionService = ElectionService(_privakeKey);
              await electionService.initialSetup();

              var result = await electionService.writeContract(
                electionService.addCandidate,
                [
                  _candidateName,
                  _candidateSlogan,
                ],
              );

              Navigator.pop(context);

              if (result != null) {
                Candidate candidate = Candidate(
                  name: _candidateName,
                  slogan: _candidateSlogan,
                );
                Navigator.pop(context, candidate);
              }
            },
          ),
        ],
      ),
    );
  }
}
