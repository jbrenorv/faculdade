import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormFieldTemplate extends Container {
  FormFieldTemplate({
    @required String title,
    @required String hintText,
    @required TextInputType keyboardType,
    String errorText,
    void Function(String) onSaved,
    String Function(String) validator,
    void Function(String) onChanged,
    bool obscureText = false,
    int maxLines = 1,
  }) : super(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title),
              TextFormField(
                keyboardType: keyboardType,
                obscureText: obscureText,
                maxLines: maxLines,
                decoration: InputDecoration(
                  errorText: errorText,
                  border: OutlineInputBorder(),
                  hintText: hintText,
                ),
                validator: validator,
                onSaved: onSaved ?? null,
                onChanged: onChanged ?? null,
              )
            ],
          ),
        );
}

/**
 * _textField({
    @required String hintText,
    @required TextInputType keyboardType,
    @required void Function(String) onSaved,
    @required String Function() validator,
    @required void Function(String) onChanged,
    bool obscureText = false,
  }) =>
      TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: validator(),
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
        validator: (data) {
          return null;
        }, //validator,
        onSaved: onSaved,
        onChanged: onChanged,
      );

 */
