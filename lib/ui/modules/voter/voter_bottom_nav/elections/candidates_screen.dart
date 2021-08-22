import 'package:flutter/material.dart';
import 'package:voters/ui/widgets/candidate_details_bottom_sheet.dart';
import 'package:voters/ui/widgets/election_candidates_card.dart';
import 'package:voters/utils/theme.dart';

class VotersCandidatesScreen extends StatelessWidget {
  const VotersCandidatesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Public Relation Officer',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: [
          Container(
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: primaryColor.withOpacity(.5),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Governorship Election - Public Relation Officer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF62961D),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '20 Candidates',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '23rd November, 2020',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'All Candidates',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 40,
                child: Divider(
                  color: blackColor.withOpacity(.5),
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ...List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ElectionCandidateCard(
                imgUrl: '',
                candidateName: '',
                noOfVotes: 100,
                catchPhrase: '',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    builder: (context) {
                      return CandidateDetailsBottomSheet();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
