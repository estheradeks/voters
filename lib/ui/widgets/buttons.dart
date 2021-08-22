import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class VotersFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isBusy;

  const VotersFilledButton({
    Key key,
    this.onPressed,
    @required this.text,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: FlatButton(
        color: primaryColor,
        height: 60,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textColor: whiteColor,
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}

class VotersOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isBusy;

  const VotersOutlinedButton(
      {Key key, this.onPressed, @required this.text, this.isBusy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 60,
      minWidth: double.infinity,
      onPressed: onPressed,
      color: primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: primaryColor,
          width: 1,
        ),
      ),
      textColor: primaryColor,
      splashColor: primaryColor.withOpacity(0.1),
      child: Text(
        text,
      ),
    );
  }
}
