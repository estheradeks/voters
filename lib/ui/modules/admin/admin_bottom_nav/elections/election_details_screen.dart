import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/candidate.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/candidates_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/create_candidate_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/create_position_screen.dart';
import 'package:voters/ui/widgets/election_position_card.dart';
import 'package:voters/utils/theme.dart';

class AdminElectionDetailScreen extends StatefulWidget {
  const AdminElectionDetailScreen({
    Key key,
    this.electionName,
  }) : super(key: key);

  final String electionName;

  @override
  _AdminElectionDetailScreenState createState() =>
      _AdminElectionDetailScreenState();
}

class _AdminElectionDetailScreenState extends State<AdminElectionDetailScreen> {
  bool _isLoading = false;
  int _noOfCandidates = 0;
  List<Candidate> _candidatesList = [];
  ElectionService electionService;

  Future<void> _getElectionCandidates() async {
    setState(() {
      _isLoading = true;
    });
    String privateKey = await StorageService().getPrivateKey();

    electionService = ElectionService(privateKey);
    var resultList = await electionService.readContract(
      electionService.getTotalCandidate,
      [],
    );
    _noOfCandidates = int.parse(resultList.first.toString());

    for (int i = 0; i < _noOfCandidates; i++) {
      var result = await electionService.readContract(
        electionService.candidateDetails,
        [
          BigInt.parse(i.toString()),
        ],
      );
      _candidatesList.add(
        Candidate(
          name: result[1],
          slogan: result[2],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getElectionCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var result = await showModalBottomSheet(
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
              // return CreatePositionScreen();
              return CreateCandidateScreen();
            },
          );
          if (result != null) {
            _candidatesList.add(result);
            _noOfCandidates = _noOfCandidates + 1;
          }

          setState(() {});
        },
        label: Text(
          'Create Candidate',
        ),
        icon: Icon(
          Icons.group_rounded,
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.electionName,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: [
          Container(
            height: 175,
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
          Text(
            widget.electionName,
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
            '$_noOfCandidates Candidates',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
          if (_candidatesList.isEmpty)
            SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  'No candidate for this election, click the button to create a candidate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (_candidatesList.isNotEmpty)
            ...List.generate(
              _candidatesList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: ElectionPositionCard(
                  positionSN: index + 1,
                  positionName: _candidatesList[index].name,
                  slogan: _candidatesList[index].slogan,
                  // noOfCandidates: 5,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => AdminCandidatesScreen(),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
