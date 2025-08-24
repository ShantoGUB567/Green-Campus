import 'package:flutter/material.dart';

class AcademicCalendarActivity extends StatelessWidget {
  const AcademicCalendarActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Calendar'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF197E46),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Academic Calendar 2024-2025',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Green University of Bangladesh',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Fall Semester
            _buildSemesterSection(
              'Fall Semester 2024',
              'September - December',
              [
                'Registration Period: August 15-30, 2024',
                'Classes Begin: September 1, 2024',
                'Mid-Term Examination: October 15-20, 2024',
                'Eid-ul-Adha Holiday: July 10-12, 2024',
                'Durga Puja Holiday: October 20-22, 2024',
                'Final Examination: December 15-25, 2024',
                'Semester Ends: December 31, 2024',
              ],
              Colors.orange,
            ),
            
            const SizedBox(height: 20),
            
            // Spring Semester
            _buildSemesterSection(
              'Spring Semester 2025',
              'January - April',
              [
                'Registration Period: December 15-30, 2024',
                'Classes Begin: January 1, 2025',
                'Mid-Term Examination: February 15-20, 2025',
                'International Mother Language Day: February 21, 2025',
                'Independence Day Holiday: March 26, 2025',
                'Final Examination: April 15-25, 2025',
                'Semester Ends: April 30, 2025',
              ],
              Colors.green,
            ),
            
            const SizedBox(height: 20),
            
            // Summer Semester
            _buildSemesterSection(
              'Summer Semester 2025',
              'May - August',
              [
                'Registration Period: April 15-30, 2025',
                'Classes Begin: May 1, 2025',
                'Mid-Term Examination: June 15-20, 2025',
                'Eid-ul-Fitr Holiday: May 25-27, 2025',
                'Final Examination: August 15-25, 2025',
                'Semester Ends: August 31, 2025',
              ],
              Colors.blue,
            ),
            
            const SizedBox(height: 20),
            
            // Important Dates
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red.shade700,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Important Deadlines',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '• Course Registration: Must be completed within specified periods\n'
                    '• Fee Payment: Due within 7 days of registration\n'
                    '• Course Drop: Within first 2 weeks of semester\n'
                    '• Grade Appeal: Within 7 days of result publication\n'
                    '• Graduation Application: Submit 3 months before graduation\n'
                    '• Transcript Request: Allow 5-7 working days',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // General Information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.blue.shade700,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'General Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '• Academic Year: 2024-2025\n'
                    '• Total Credits Required: 130-140 (varies by program)\n'
                    '• Minimum GPA for Graduation: 2.50\n'
                    '• Maximum Course Load: 18 credits per semester\n'
                    '• Office Hours: Sunday-Thursday, 9:00 AM - 5:00 PM\n'
                    '• Emergency Contact: +880-2-9122565',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterSection(String title, String period, List<String> events, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 16,
                        color: color.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...events.map((event) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    event,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
