import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mom/pages/client_page.dart';

import '../services/mom/mom_service.dart';
import '../widgets/application_typy_button_widget.dart';
import 'sensors_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  late final MomService _momService;

  @override
  void initState() {
    _momService = context.read<MomService>();
    _momService.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo!'),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            splashRadius: 20.0,
            icon: const Icon(
              Icons.wifi,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              
            },
            splashRadius: 20.0,
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 32.0,
              ),
              child: Text(
                'Selecione um tipo de aplicação',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ApplicationTypyButtonWidget(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SensorsPage(),
                        ),
                      );
                    },
                    text: 'Sensor',
                  ),
                ),
                Flexible(
                  child: ApplicationTypyButtonWidget(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ClientPage(),
                        ),
                      );
                    },
                    text: 'Client',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
