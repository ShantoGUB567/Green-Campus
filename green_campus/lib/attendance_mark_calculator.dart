import 'package:flutter/material.dart';

class AttendanceMarkCalculatorPage extends StatefulWidget {
  const AttendanceMarkCalculatorPage({super.key});

  @override
  State<AttendanceMarkCalculatorPage> createState() => _AttendanceMarkCalculatorPageState();
}

class _AttendanceMarkCalculatorPageState extends State<AttendanceMarkCalculatorPage> {
  final TextEditingController _totalClassesController = TextEditingController();
  final TextEditingController _attendedClassesController = TextEditingController();

  double? _calculatedMark;
  String? _errorMessage;

  @override
  void dispose() {
    _totalClassesController.dispose();
    _attendedClassesController.dispose();
    super.dispose();
  }

  void _calculateMark() {
    setState(() {
      _errorMessage = null;
      _calculatedMark = null;

      final String totalText = _totalClassesController.text.trim();
      final String attendedText = _attendedClassesController.text.trim();

      if (totalText.isEmpty || attendedText.isEmpty) {
        _errorMessage = 'Please enter both values.';
        return;
      }

      final int? total = int.tryParse(totalText);
      final int? attended = int.tryParse(attendedText);

      if (total == null || attended == null) {
        _errorMessage = 'Please enter valid whole numbers.';
        return;
      }
      if (total <= 0) {
        _errorMessage = 'Total classes must be greater than 0.';
        return;
      }
      if (attended < 0) {
        _errorMessage = 'Attended classes cannot be negative.';
        return;
      }
      if (attended > total) {
        _errorMessage = 'Attended classes cannot exceed total classes.';
        return;
      }

      final double mark = (attended / total) * 10.0;
      _calculatedMark = double.parse(mark.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Mark Calculator'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberField(
                controller: _totalClassesController,
                label: 'Number of classes in semester',
                hint: 'e.g. 42',
              ),
              const SizedBox(height: 16),
              _buildNumberField(
                controller: _attendedClassesController,
                label: 'Number of classes you attended',
                hint: 'e.g. 39',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF197E46),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onPressed: _calculateMark,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              if (_calculatedMark != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF197E46).withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Attendance Mark',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF197E46),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_calculatedMark / 10.00',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF197E46),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF197E46)),
        ),
        prefixIcon: const Icon(Icons.class_),
      ),
    );
  }
}


