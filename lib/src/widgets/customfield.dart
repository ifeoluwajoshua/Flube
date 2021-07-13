import 'package:flube/src/helpers/fonts.dart';
import 'package:flutter/material.dart';

Widget customField(
  TextEditingController text,
  FormFieldValidator fun,
  String hint,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    child: TextFormField(
      controller: text,
      validator: fun,
      keyboardType: TextInputType.url,
      autofocus: false,
      decoration: InputDecoration(
          labelText: hint,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      style: nStyle,
    ),
  );
}
