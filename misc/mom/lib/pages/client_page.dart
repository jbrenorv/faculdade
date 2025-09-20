import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/mom/mom_message.dart';
import '../services/mom/mom_service.dart';
import '../utils/constants.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final MomService _momService;

  final List<String> _topics = [];
  
  final Map<String, MomMessage> _messages = {};

  final _topicController = TextEditingController();

  @override
  void initState() {
    _momService = context.read<MomService>();

    _momService.onMessage.listen((message) {
      if (mounted) {
        setState(() {
          _messages[message.topic] = message;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _topicController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixText: Constants.topicPrefix,
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () {
                          final topic = Constants.topicPrefix + _topicController.text;
                          _momService.subscribe(topic);
                          setState(() {
                            _topics.add(topic);
                          });
                        },
                        child: const Text('Inscrever'),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tópicos inscritos',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _topics.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_topics[index]),
                        trailing: IconButton(
                          onPressed: () {
                            _momService.unsubscribe(_topics[index]);
                            setState(() {
                              _topics.remove(_topics[index]);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Mensagens',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final keys = _messages.keys.toList();
                      return ListTile(
                        leading: const Icon(Icons.sensors),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _messages[keys[index]]!.sensorType.toUpperCase(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _messages[keys[index]]!.topic,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _messages[keys[index]]!.sensorName,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${_messages[keys[index]]!.min} - ${_messages[keys[index]]!.max}',
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _messages[keys[index]]!.date.toString(),
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          _messages[keys[index]]!.value.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
