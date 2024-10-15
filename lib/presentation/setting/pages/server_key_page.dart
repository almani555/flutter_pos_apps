import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_datasource.dart';

class ServerKeyPage extends StatefulWidget {
  const ServerKeyPage({super.key});

  @override
  State<ServerKeyPage> createState() => _ServerKeyPageState();
}

class _ServerKeyPageState extends State<ServerKeyPage> {
  TextEditingController? serverKeyController;
  String serverKey = '';

  Future<void> getServerKey() async {
    serverKey = await AuthLocalDatasource().getMidtransServerKey();
  }

  @override
  void initState() {
    super.initState();
    serverKeyController = TextEditingController();
    getServerKey();
    Future.delayed(const Duration(seconds: 1), () {
      serverKeyController!.text = serverKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Server Setting'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: serverKeyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Server Key Midtrans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AuthLocalDatasource()
                  .saveMidtransServerKey(serverKeyController!.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Server key saved'),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
