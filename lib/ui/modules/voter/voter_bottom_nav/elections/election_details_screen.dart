import 'package:flutter/material.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/elections/candidates_screen.dart';
import 'package:voters/ui/widgets/election_position_card.dart';
import 'package:voters/utils/theme.dart';

class VoterElectionDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Governorship Election',
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
            'Governorship Election',
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
            '20 Positions',
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
                'All Positions',
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
              child: ElectionPositionCard(
                positionSN: index + 1,
                positionName: 'Position Name',
                // noOfCandidates: 5,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VotersCandidatesScreen(),
                    ),
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
