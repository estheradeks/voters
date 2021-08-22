import 'package:flutter/material.dart';

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
