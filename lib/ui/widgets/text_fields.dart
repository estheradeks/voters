import 'package:flutter/material.dart';
import 'package:voters/utils/theme.dart';

class VotersTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Function(String) onChanged;
  final Function(String) validator;
  final bool readOnly;

  const VotersTextField({
    Key key,
    this.controller,
    this.focusNode,
    @required this.hintText,
    @required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.textInputAction,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Center(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              readOnly: readOnly,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: greyColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 1.5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: greyColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: greyColor,
                  ),
                ),
                hintText: hintText,
              ),
              obscureText: obscureText,
            ),
          ),
          Positioned(
            left: 15,
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Center(
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
