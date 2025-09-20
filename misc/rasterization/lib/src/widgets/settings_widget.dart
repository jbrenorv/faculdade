import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../entity/resolution.dart';
import 'setting_item_widget.dart';
import 'color_picker_widget.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  final resolutions = const <Resolution>[
    Resolution(100, 100),
    Resolution(300, 300),
    Resolution(600, 600),
    Resolution(800, 600),
    Resolution(1920, 1080),
  ];

  void _onColorChanged(Color color) {
    context.read<HomeBloc>().changeColor(color.value);
  }

  void _onResolutionChanged(Resolution? resolution) {
    if (resolution != null) {
      context.read<HomeBloc>().changeResolution(resolution);
      Future.delayed(
        const Duration(milliseconds: 200),
        () => FocusScope.of(context).unfocus()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.all(8.0),
      title: Row(
        children: const [
          Icon(Icons.settings_outlined),
          SizedBox(width: 8.0),
          Text(
            'Configurações',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      children: [
        SettingItem(
          name: 'Resolução',
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return DropdownButton<Resolution>(
                isExpanded: true,
                value: state.imageEntity.resolution,
                items: resolutions.map((resolution) => DropdownMenuItem(
                  value: resolution,
                  child: Center(
                    child: Text(
                      resolution.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )).toList(),
                onChanged: _onResolutionChanged,
              );
            },
          ),
        ),
        SettingItem(
          name: 'Cor',
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return ColorPickerWidget(
                pickerColor: Color(state.imageEntity.color),
                onColorChanged: _onColorChanged,
              );
            },
          ),
        ),
      ],
    );
  }
}
