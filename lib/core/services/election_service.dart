import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ElectionService {
  ElectionService(String kPrivateKey) {
    this.privateKey = kPrivateKey;
    // initialSetup();
  }

  // http client
  Client httpClient;
  // web3 client
  Web3Client web3client;

  // rcp url
  String rcpUrl = 'https://6fcf-197-210-47-21.ngrok.io';
  // String rcpUrl = 'http://10.0.2.2:7545';
  // ws url
  // String wsUrl = "ws://10.0.2.2:7545/";
  String wsUrl = "https://6fcf-197-210-47-21.ngrok.io";

  /// This will construct [credentials] with the provided [privateKey]
  /// and load the Ethereum address in [myAdderess] specified by these credentials.
  // String privateKey =
  //     '077f6e339718cc55ec567b24ec24d301992f6d09b1c91fdfa60f39a4f3eca0fc';

  String privateKey;

  // credentials
  Credentials credentials;
  // my ethereum address
  EthereumAddress myEthereumAddress;

  /// This will parse an Ethereum address of the contract in [contractAddress]
  /// from the hexadecimal representation present inside the [ABI]
  String abi;
  // contract address
  EthereumAddress contractAddress;

  // deployed contract
  DeployedContract deployedContract;

  // contact functions
  ContractFunction getAdmin;
  ContractFunction addCandidate;
  ContractFunction setElectionDetails;
  ContractFunction getAdminName;
  ContractFunction getAdminEmail;
  ContractFunction getAdminTitle;
  ContractFunction getElectionTitle;
  ContractFunction getOrganizationTitle;
  ContractFunction getTotalCandidate;
  ContractFunction getTotalVoter;
  ContractFunction registerAsVoter;
  ContractFunction verifyVoter;
  ContractFunction vote;
  ContractFunction endElection;
  ContractFunction getStart;
  ContractFunction getEnd;
  ContractFunction candidateDetails;
  ContractFunction voterDetails;

  Future<void> initialSetup() async {
    httpClient = Client();
    web3client = Web3Client(
      rcpUrl,
      httpClient,
      socketConnector: () {
        return IOWebSocketChannel.connect(wsUrl).cast<String>();
      },
    );

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Election.json");
    var jsonFile = jsonDecode(abiStringFile);
    abi = jsonEncode(jsonFile["abi"]);
    contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
    log('contract address is election service $contractAddress');
  }

  getCredentials() async {
    log('private key is election service $privateKey');
    credentials = await web3client.credentialsFromPrivateKey(privateKey);
    // credentials = await web3client.credentialsFromPrivateKey('077f6e339718cc55ec567b24ec24d301992f6d09b1c91fdfa60f39a4f3eca0fc');
    myEthereumAddress = await credentials.extractAddress();
    log('eth address is election service $myEthereumAddress');
  }

  getDeployedContract() async {
    deployedContract = DeployedContract(
      ContractAbi.fromJson(abi, "Election"),
      contractAddress,
    );
    // get functions
    // get the admin
    getAdmin = deployedContract.function('getAdmin');
    // add a candidate
    addCandidate = deployedContract.function('addCandidate');
    // get the election details
    setElectionDetails = deployedContract.function('setElectionDetails');
    // get admin name
    getAdminName = deployedContract.function('getAdminName');
    // get admin email
    getAdminEmail = deployedContract.function('getAdminEmail');
    // get admin title
    getAdminTitle = deployedContract.function('getAdminTitle');
    // get elction title
    getElectionTitle = deployedContract.function('getElectionTitle');
    // get organization title
    getOrganizationTitle = deployedContract.function('getOrganizationTitle');
    // get total candidates
    getTotalCandidate = deployedContract.function('getTotalCandidate');
    // get total voters
    getTotalVoter = deployedContract.function('getTotalVoter');
    // register as voter
    registerAsVoter = deployedContract.function('registerAsVoter');
    // verify voter
    verifyVoter = deployedContract.function('verifyVoter');
    // vote
    vote = deployedContract.function('vote');
    // end election
    endElection = deployedContract.function('endElection');
    // get election start
    getStart = deployedContract.function('getStart');
    // get election end
    getEnd = deployedContract.function('getEnd');
    // candidate details
    candidateDetails = deployedContract.function('candidateDetails');
    // candidate details
    voterDetails = deployedContract.function('voterDetails');
  }

  /// This will call a [functionName] with [functionArgs] as parameters
  /// defined in the [contract] and returns its result
  Future<List<dynamic>> readContract(
    ContractFunction functionName,
    List<dynamic> functionArgs,
  ) async {
    log('result from read contract => ${functionName.name} function');
    var queryResult = await web3client.call(
      // sender: myEthereumAddress,
      contract: deployedContract,
      function: functionName,
      params: functionArgs,
    );
    log('result from read contract => ${functionName.name} function  =>> is $queryResult');
    return queryResult;
  }

  /// Signs the given transaction using the keys supplied in the [credentials] object
  /// to upload it to the client so that it can be executed
  Future<String> writeContract(
    ContractFunction functionName,
    List<dynamic> functionArgs,
  ) async {
    log('result from write contract => ${functionName.name}');

    var result = await web3client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: deployedContract,
        function: functionName,
        parameters: functionArgs,
        // maxGas: 60,
        // gasPrice: EtherAmount.inWei(BigInt.from(50)),
      ),
    );

    log('result from write contract => ${functionName.name} function  =>> is $result');

    return result;
  }
}
