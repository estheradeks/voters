import 'package:flutter/material.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/admin_bottom_nav.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
import 'package:voters/ui/widgets/buttons.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          height: 65,
          width: 80,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

void showErrorDialog(BuildContext context, [String title]) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: IntrinsicHeight(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/ic_failed.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(height: 20),
                Text(
                  title ?? 'Something went wrong.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSuccessDialog(BuildContext context, [String title]) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: IntrinsicHeight(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/ic_success.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(height: 20),
                Text(
                  title ?? 'Operation Successful.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSuccessBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      return Container(
        height: 350,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_success.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Face verification successful!',
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            VotersOutlinedButton(
              text: 'Continue',
              onPressed: () async {
                StorageService storageService = StorageService();
                String role = await storageService.getRole();
                bool isAdmin = role == 'admin';
                Navigator.pop(context);

                // go to dashboard
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        isAdmin ? AdminBottomNav() : VoterBottomNav(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void showErrorBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      return Container(
        height: 350,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_failed.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Face verification not successful!',
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            VotersOutlinedButton(
              text: 'Continue',
              onPressed: () async {
                Navigator.pop(context);

                // log out
                StorageService storageService = StorageService();
                await storageService.removeAddress();
                await storageService.removePrivateKey();
                await storageService.removeRole();

                // go to login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GetStartedScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
