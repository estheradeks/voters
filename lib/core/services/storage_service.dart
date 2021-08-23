import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // save address
  Future saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }

  // save private key
  Future savePrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privatekey', privateKey);
  }

  // save role
  Future saveRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  // save vote status
  Future saveVoteStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasVoted', status);
  }

  // get address
  Future getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address');
  }

  // get private key
  Future getPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('privatekey');
  }

  // get vote status
    Future getVoteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasVoted');
  }

  // get role
  Future getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // remove address
  Future removeAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('address');
  }

  // remove private key
  Future removePrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privatekey');
  }

  // remove role
  Future removeRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
  }

  // remove vote status
   Future removeVoteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasVoted');
  }
}
