import 'package:flutter/material.dart';
import 'native_bridge.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _osVersion = "Unknown";

  Future<void> _getDeviceVersion() async {
    final version = await NativeBridge.getDeviceVersion();
    if (mounted) {
      setState(() {
        _osVersion = version ?? "Unknown";
      });
    }
  }

  void _makePhoneCall() {
    NativeBridge.makeCall("+628123456789");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _makePhoneCall,
                icon: const Icon(Icons.phone),
                label: const Text('Call +628123456789'),
              ),
              const SizedBox(height: 32),
              const Text('Native integration result:'),
              Text(
                _osVersion,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getDeviceVersion, // Refresh on tap
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
