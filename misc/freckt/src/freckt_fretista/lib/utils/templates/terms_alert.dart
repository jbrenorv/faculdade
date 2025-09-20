import 'package:flutter/material.dart';

class TermsAlert extends Container {
  TermsAlert()
      : super(
          height: 50.0,
          child: Center(
            child: Text.rich(
              TextSpan(
                text: 'Ao se cadastrar, você concorda com os ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'Termos de Serviço',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' e '),
                  TextSpan(
                    text: 'Política de Privacidade',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' do Freckt'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
}
