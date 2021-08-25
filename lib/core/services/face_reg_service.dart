import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:http/http.dart' as http;

class FaceRegService {
  // upload image to firebase storage and get a link
  static Future<String> uploadProfilePicture(
    File image,
  ) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("faces")
          .child("${DateTime.now().microsecondsSinceEpoch}.png");
      UploadTask task = reference.putFile(image);
      await task;
      var url = await reference.getDownloadURL();
      return url;
    } catch (e) {
      return 'Something went wrong, try again.';
    }
  }

  // verify picture
  static Future<bool> verifyFace(
      File currentImage, String ethPrivateKey) async {
    // upload to fireabse
    bool verificationPassed;
    try {
      String imageUrl = await uploadProfilePicture(currentImage);

      if (imageUrl != 'Something went wrong, try again.') {
        // upload the new picture
        FirebaseFirestore ff = FirebaseFirestore.instance;
        await ff.collection('faces').doc(ethPrivateKey).update(
          {
            'duplicate_img': imageUrl,
          },
        );

        // get former picture from firebase
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('faces')
            .doc(ethPrivateKey)
            .get();

        String duplicateImage = documentSnapshot.data()['duplicate_img'];
        String originalImage = documentSnapshot.data()['original_img'];

        // hit the api with the two links
        String url =
            'https://face-verification2.p.rapidapi.com/faceverification';
        Map<String, String> headers = {
          'content-type': 'application/x-www-form-urlencoded',
          'x-rapidapi-host': 'face-verification2.p.rapidapi.com',
          'x-rapidapi-key': 'b34088d53fmsh7cc5eec3ec15aa4p1b4b9bjsncde00a05ee41'
        };

        Map<String, String> body = {
          'linkFile1': duplicateImage,
          'linkFile2': originalImage,
        };

        var response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);

          log('json here for api is $data');

          String resultMessage = data["data"]['resultMessage'];
          int similarPercent = data['similarPercent'];


          if (resultMessage.contains('different')) {
            verificationPassed = false;
          } else if (resultMessage.contains('same')) {
            verificationPassed = true;
          } else if (resultMessage.contains('NotFound')) {
            verificationPassed = false;
          }
        } else {
          return false;
        }

        // return the result
        // The two faces belong to the different people.
        // "The two faces belong to the same person.
        //Face NotFound in first image

      }
    } catch (e) {
      verificationPassed = false;
    }
    return verificationPassed;
  }

  // take picture during sign up and put link in firebase
  static Future<bool> registerFace(File image, String ethPrivateKey) async {
    try {
      String url = await uploadProfilePicture(image);

      if (url != 'Something went wrong, try again.') {
        log('the eth key here is $ethPrivateKey');
        // image upload was successful
        // insert to firebase
        FirebaseFirestore ff = FirebaseFirestore.instance;
        await ff.collection('faces').doc(ethPrivateKey.toString()).set(
          {
            'original_img': url,
          },
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('error while registering face $e');
      return false;
    }
  }
}
