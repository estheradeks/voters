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
}
