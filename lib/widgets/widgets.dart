import 'package:flutter/material.dart';

Widget heading(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.green,
    ),
    textAlign: TextAlign.center,
  );
}

Widget scaffoldtext(String text) {
  return Text(text,
      style: TextStyle(
        fontSize: 15,
        color: Colors.green[300],
      ));
}
Widget mytext(String text) {
  return Text(text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.green[300],
      ));
}

Widget search(String hint, TextEditingController con, Icon conss, [void Function(String)? onChanged]) {
  return TextFormField(
    controller: con,
    onChanged: onChanged,
    decoration: InputDecoration(
      prefixIcon: conss,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.green[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.green[300]!),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
    ),
  );
}
SnackBar mySnackBar(
  String message,
) {
  return SnackBar(
    elevation: 5.0,
    duration: const Duration(milliseconds: 6000),
    margin: const EdgeInsets.only(right:40, left:40, bottom:20,),
    padding: const EdgeInsets.all(10),
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
    content: Text(
      message,
      textAlign: TextAlign.start,
      style:  TextStyle(
        color: Colors.grey[800],
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
