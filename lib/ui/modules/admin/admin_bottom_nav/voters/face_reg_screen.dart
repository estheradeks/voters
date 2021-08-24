import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/services/face_reg_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/main.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/utils/theme.dart';

class VotersFaceRegScreen extends StatefulWidget {
  @override
  _VotersFaceRegScreenState createState() => _VotersFaceRegScreenState();
}

class _VotersFaceRegScreenState extends State<VotersFaceRegScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        cameras.firstWhere((e) => e.lensDirection == CameraLensDirection.front),
        ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Face",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "You need to verify your identity before accessing the election.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              // Text(
              //   "Please, make sure you are close to the camera",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 13,
              //   ),
              // ),
              SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CameraPreview(
                        controller,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await verifyIdentity(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future verifyIdentity(BuildContext context) async {
    final image = await controller.takePicture();
    File imageFile = File(image.path);

    showLoadingDialog(context);
    String ethPrivateKey = await StorageService().getPrivateKey();

    bool result = await FaceRegService.verifyFace(imageFile, ethPrivateKey);

    log('result for face verification is $result');

    Navigator.pop(context);

    if (result) {
      showSuccessBottomSheet(context);
    } else {
      showErrorBottomSheet(context);
    }
    // call verify identity endpoint

    // if it is true == success
    // show dialog saying they have verified their identity
    // if it is false, show dialog, clear credentials and log out of the system
    // ResponseDetails responseDetails =
    //     await AttendanceService.uploadProfilePicture(imageFile);
    // if (responseDetails.status) {
    //   String url = responseDetails.object as String;
    //   ResponseDetails attendanceResponse = await AttendanceService.validateFace(
    //     matricNo: userDetails.matric,
    //     imageUrl: url,
    //   );
    //   Navigator.pop(context);
    //   bool isFaceVerificationSuccessful = attendanceResponse.status;
    //   String message = isFaceVerificationSuccessful ? 'Face Verified!' : attendanceResponse.message;
    //   String description = isFaceVerificationSuccessful ? 'Please continue votin!' : 'Please make sure your face is properly captured.';
    //   showModalBottomSheet(
    //     context: context,
    //     builder: (_) {
    //       return ResponseBottomSheet(
    //         icon: Icon(
    //           isAttendanceSuccessful
    //               ? Icons.check_rounded
    //               : Icons.close_rounded,
    //         ),
    //         message: message,
    //         description: description,
    //         buttonText: isAttendanceSuccessful ? 'Continue' : 'Mark Again',
    //         buttonColor: isAttendanceSuccessful ? Colors.green : Colors.red,
    //         onButtonPressed: () {

    //         },
    //       );
    //     },
    //   );
    // } else {
    //   Navigator.pop(context);

    //   showErrorDialog(context, responseDetails);
    // }
  }
}
