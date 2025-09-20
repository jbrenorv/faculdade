import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/utils/consts.dart';

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
  }) : super(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title),
              TextFormField(
                keyboardType: keyboardType,
                obscureText: obscureText,
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
