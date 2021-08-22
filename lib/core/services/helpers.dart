import 'package:firebase_core/firebase_core.dart';

String catchFirebaseException(FirebaseException firebaseException) {
  switch (firebaseException.code) {
    case 'user-disabled':
      return 'Your account has been diabled. Contact support.';
    case 'user-not-found':
      return 'No user found with the provided credentials';
    case 'invalid-credential':
      return 'Credentials provided are incorrect';
    case 'wrong-password':
      return 'The password provided is incorrect';
    default:
      return 'Something went wrong, try again';
  }
}
