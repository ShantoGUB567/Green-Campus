import 'package:flutter/material.dart';
import 'services/firebase_service.dart';

class TestConnectionPage extends StatefulWidget {
  const TestConnectionPage({super.key});

  @override
  State<TestConnectionPage> createState() => _TestConnectionPageState();
}

class _TestConnectionPageState extends State<TestConnectionPage> {
  bool _isTesting = false;
  String _connectionStatus = 'Not tested';
  Color _statusColor = Colors.grey;

  Future<void> _testConnection() async {
    setState(() {
      _isTesting = true;
      _connectionStatus = 'Testing...';
      _statusColor = Colors.orange;
    });

    try {
      final isConnected = await FirebaseService.testConnection();
      setState(() {
        _isTesting = false;
        if (isConnected) {
          _connectionStatus = 'Connection successful!';
          _statusColor = Colors.green;
        } else {
          _connectionStatus = 'Connection failed!';
          _statusColor = Colors.red;
        }
      });
    } catch (e) {
      setState(() {
        _isTesting = false;
        _connectionStatus = 'Error: ${e.toString()}';
        _statusColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Connection Test'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_done,
                size: 100,
                color: Color(0xFF197E46),
              ),
              const SizedBox(height: 30),
              const Text(
                'Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'URL: greencampus-949c7-default-rtdb.firebaseio.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: _statusColor),
                ),
                child: Column(
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _statusColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _connectionStatus,
                      style: TextStyle(
                        fontSize: 16,
                        color: _statusColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isTesting ? null : _testConnection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF197E46),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isTesting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Test Connection',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
