import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/helpers/validators.dart';
import 'package:flutter/material.dart';

class UrlField extends StatelessWidget {
  const UrlField({
    Key? key,
    required this.formkey,
    required this.url,
    this.hint,
  }) : super(key: key);
  final TextEditingController url;
  final GlobalKey formkey;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: customField(url, validateN, hint!));
  }
}

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
