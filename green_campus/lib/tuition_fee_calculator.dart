import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TuitionFeeCalculatorPage extends StatefulWidget {
  const TuitionFeeCalculatorPage({super.key});

  @override
  State<TuitionFeeCalculatorPage> createState() => _TuitionFeeCalculatorPageState();
}

class _TuitionFeeCalculatorPageState extends State<TuitionFeeCalculatorPage> {
  final TextEditingController _perCreditFeeController = TextEditingController();
  final TextEditingController _totalCreditsController = TextEditingController();
  final TextEditingController _waiverPercentageController = TextEditingController();
  final TextEditingController _nonWaiverCreditsController = TextEditingController();

  // Fixed fees
  static const double registrationFee = 6000.0;
  static const double itLibraryFee = 1500.0;
  static const double clubFee = 200.0;
  static const double firstInstallment = 15700.0;

  double? _waivedCredits;
  double? _waivedTuitionAmount;
  double? _payableTuitionFee;
  double? _totalPayable;
  double? _remainingAmount;
  double? _secondInstallment;
  double? _thirdInstallment;

  @override
  void dispose() {
    _perCreditFeeController.dispose();
    _totalCreditsController.dispose();
    _waiverPercentageController.dispose();
    _nonWaiverCreditsController.dispose();
    super.dispose();
  }

  void _calculateFees() {
    setState(() {
      // Reset all calculated values
      _waivedCredits = null;
      _waivedTuitionAmount = null;
      _payableTuitionFee = null;
      _totalPayable = null;
      _remainingAmount = null;
      _secondInstallment = null;
      _thirdInstallment = null;

      // Get input values
      final double? perCreditFee = double.tryParse(_perCreditFeeController.text);
      final double? totalCredits = double.tryParse(_totalCreditsController.text);
      final double? waiverPercentage = double.tryParse(_waiverPercentageController.text);
      final double? nonWaiverCredits = double.tryParse(_nonWaiverCreditsController.text);

      // Validate inputs
      if (perCreditFee == null || totalCredits == null || 
          waiverPercentage == null || nonWaiverCredits == null) {
        return;
      }

      if (perCreditFee < 0 || totalCredits < 0 || 
          waiverPercentage < 0 || waiverPercentage > 100 || 
          nonWaiverCredits < 0 || nonWaiverCredits > totalCredits) {
        return;
      }

      // Calculate waived credits
      _waivedCredits = totalCredits - nonWaiverCredits;

      // Calculate waived tuition amount
      _waivedTuitionAmount = (_waivedCredits! * perCreditFee) * (waiverPercentage / 100);

      // Calculate payable tuition fee
      _payableTuitionFee = (totalCredits * perCreditFee) - _waivedTuitionAmount!;

      // Calculate total payable
      _totalPayable = _payableTuitionFee! + registrationFee + itLibraryFee + clubFee;

      // Calculate installments
      _remainingAmount = _totalPayable! - firstInstallment;
      if (_remainingAmount! > 0) {
        _secondInstallment = _remainingAmount! / 2;
        _thirdInstallment = _remainingAmount! / 2;
      } else {
        _secondInstallment = 0;
        _thirdInstallment = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tuition Fee Calculator'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fee Inputs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF197E46),
                ),
              ),
              const SizedBox(height: 16),
              
              // Input fields
              _buildNumberField(
                controller: _perCreditFeeController,
                label: 'Per Credit Tuition Fee',
                hint: 'e.g. 5000',
                prefixIcon: Icons.attach_money,
              ),
              const SizedBox(height: 16),
              
              _buildNumberField(
                controller: _totalCreditsController,
                label: 'Total Credits',
                hint: 'e.g. 18',
                prefixIcon: Icons.school,
              ),
              const SizedBox(height: 16),
              
              _buildNumberField(
                controller: _waiverPercentageController,
                label: 'Waiver Percentage (0-100)',
                hint: 'e.g. 25',
                prefixIcon: Icons.percent,
              ),
              const SizedBox(height: 16),
              
              _buildNumberField(
                controller: _nonWaiverCreditsController,
                label: 'Non-Waiver Credits',
                hint: 'e.g. 6',
                prefixIcon: Icons.block,
              ),
              const SizedBox(height: 20),

              // Fixed fees section
              _buildFixedFeesSection(),
              const SizedBox(height: 20),

              // Calculate button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF197E46),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onPressed: _calculateFees,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate Fees'),
                ),
              ),
              const SizedBox(height: 24),

              // Results section
              if (_totalPayable != null) _buildResultsSection(),
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
    required IconData prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF197E46)),
        ),
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }

  Widget _buildFixedFeesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fixed Fees',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF197E46),
            ),
          ),
          const SizedBox(height: 12),
          _buildFixedFeeRow('Registration Fees', registrationFee),
          _buildFixedFeeRow('IT & Library Services', itLibraryFee),
          _buildFixedFeeRow('Club Fee', clubFee),
        ],
      ),
    );
  }

  Widget _buildFixedFeeRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            '৳${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF197E46),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF197E46).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fee Breakdown',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF197E46),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildResultRow('Waived Credits', _waivedCredits!, 'credits'),
          _buildResultRow('Waived Tuition Amount', _waivedTuitionAmount!, '৳'),
          _buildResultRow('Payable Tuition Fee', _payableTuitionFee!, '৳'),
          _buildResultRow('Total Payable', _totalPayable!, '৳'),
          
          const Divider(height: 24, color: Color(0xFF197E46)),
          
          const Text(
            'Installment Plan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF197E46),
            ),
          ),
          const SizedBox(height: 12),
          
          _buildInstallmentRow('1st Installment', firstInstallment, '৳'),
          _buildInstallmentRow('2nd Installment', _secondInstallment!, '৳'),
          _buildInstallmentRow('3rd Installment', _thirdInstallment!, '৳'),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            '${value.toStringAsFixed(2)} $unit',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF197E46),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentRow(String label, double amount, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(2)} $unit',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF197E46),
            ),
          ),
        ],
      ),
    );
  }
}
