
import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/candidate.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/widgets/election_candidates_card.dart';
import 'package:voters/utils/theme.dart';

class ElectionResultsScreen extends StatefulWidget {
  const ElectionResultsScreen({
    Key key,
  }) : super(key: key);

  @override
  _ElectionResultsScreenState createState() => _ElectionResultsScreenState();
}

class _ElectionResultsScreenState extends State<ElectionResultsScreen> {
  bool _hasElectionStarted;
  bool _hasElectionEnded;
  bool _isLoading = false;
  int _noOfCandidates = 0;
  List<Candidate> _candidatesList = [];
  ElectionService electionService;

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    // get election start value
    String kPrivateKey = await StorageService().getPrivateKey();
    electionService = ElectionService(kPrivateKey);
    await electionService.initialSetup();
    var resultListStart = await electionService.readContract(
      electionService.getStart,
      [],
    );
    _hasElectionStarted = resultListStart.first;

    // get election end value
    var resultListEnd = await electionService.readContract(
      electionService.getEnd,
      [],
    );
    _hasElectionEnded = resultListEnd.first;

    // get candidates
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
          voteCount: int.parse(BigInt.parse(result[3].toString()).toString()),
        ),
      );
    }

    _candidatesList = _candidatesList
      ..sort((a, b) => b.voteCount.compareTo(a.voteCount));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            children: [
              if (_hasElectionStarted)
                Text(
                  'Election is Ongoing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              if (_hasElectionEnded)
                Text(
                  'Election has Ended',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              if (!_hasElectionStarted && !_hasElectionStarted)
                Text(
                  'Election has not Started',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              SizedBox(
                height: 30,
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
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: blackColor.withOpacity(.5),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    _candidatesList.length.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!_hasElectionStarted && !_hasElectionStarted)
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      'The election has not started, please wait...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (_hasElectionStarted || _hasElectionEnded)
                ...List.generate(
                  _candidatesList.length,
                  (index) => Column(
                    children: [
                      ElectionCandidateCard(
                        positionSN: index + 1,
                        candidateName: _candidatesList[index].name,
                        catchPhrase: _candidatesList[index].slogan,
                        noOfVotes: _candidatesList[index].voteCount,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}
