import 'package:flutter/material.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/election_details_screen.dart';
import 'package:voters/ui/widgets/all_election_card.dart';
import 'package:voters/ui/widgets/upcoming_election.dart';

class AdminElectionsScreen extends StatefulWidget {
  const AdminElectionsScreen({Key key}) : super(key: key);

  @override
  _AdminElectionsScreenState createState() => _AdminElectionsScreenState();
}

class _AdminElectionsScreenState extends State<AdminElectionsScreen> {
  void _pushToElectionDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminElectionDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.0).add(
        EdgeInsets.only(
          top: 15.0,
        ),
      ),
      children: [
        Text(
          'Upcoming Elections',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF62961D),
          ),
        ),
        SizedBox(
          height: 270,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            children: [
              UpcomingElectionCard(
                onTap: _pushToElectionDetails,
              ),
              SizedBox(
                width: 20,
              ),
              UpcomingElectionCard(
                onTap: _pushToElectionDetails,
              ),
              SizedBox(
                width: 20,
              ),
              UpcomingElectionCard(
                onTap: _pushToElectionDetails,
              ),
              SizedBox(
                width: 20,
              ),
              UpcomingElectionCard(
                onTap: _pushToElectionDetails,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'All Elections',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF62961D),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          itemBuilder: (_, __) {
            return AllElectionCard(
              onTap: _pushToElectionDetails,
            );
          },
          separatorBuilder: (_, __) {
            return SizedBox(
              height: 15,
            );
          },
          itemCount: 12,
        ),
      ],
    );
  }
}
