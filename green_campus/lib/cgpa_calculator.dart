import 'package:flutter/material.dart';

class CGPACalculatorPage extends StatefulWidget {
  const CGPACalculatorPage({super.key});

  @override
  State<CGPACalculatorPage> createState() => _CGPACalculatorPageState();
}

class _CGPACalculatorPageState extends State<CGPACalculatorPage> {
  final List<CourseInput> _courses = [];
  double? _calculatedGPA;

  final List<double> _creditOptions = [0.0, 1.0, 1.5, 2.0, 3.0];
  final Map<String, double> _gradeOptions = {
    'A+': 4.00,
    'A': 3.75,
    'A-': 3.50,
    'B+': 3.25,
    'B': 3.00,
    'B-': 2.75,
    'C+': 2.50,
    'C': 2.25,
    'D': 2.00,
    'F': 0.00,
  };

  @override
  void initState() {
    super.initState();
    // Initialize with 2 default courses
    _courses.add(CourseInput(credit: 3.0, grade: 'A'));
    _courses.add(CourseInput(credit: 3.0, grade: 'A'));
  }

  void _addCourse() {
    setState(() {
      _courses.add(CourseInput(credit: 3.0, grade: 'A'));
    });
  }

  void _removeCourse(int index) {
    if (_courses.length > 2) {
      setState(() {
        _courses.removeAt(index);
        _calculateGPA();
      });
    }
  }

  void _updateCourse(int index, double? credit, String? grade) {
    setState(() {
      if (credit != null) _courses[index].credit = credit;
      if (grade != null) _courses[index].grade = grade;
      _calculateGPA();
    });
  }

  void _calculateGPA() {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (var course in _courses) {
      totalCredits += course.credit;
      totalGradePoints += course.credit * _gradeOptions[course.grade]!;
    }

    if (totalCredits > 0) {
      setState(() {
        _calculatedGPA = totalGradePoints / totalCredits;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CGPA Calculator'),
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
                'Course Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF197E46),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(_courses.length, (index) {
                return _buildCourseInput(index);
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addCourse,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF197E46),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _courses.length > 2 ? () => _removeCourse(_courses.length - 1) : null,
                    icon: const Icon(Icons.remove),
                    label: const Text('Remove Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _courses.length > 2 ? Colors.red : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_calculatedGPA != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF197E46).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Semester GPA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF197E46),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _calculatedGPA!.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF197E46),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Credits: ${_courses.fold(0.0, (sum, course) => sum + course.credit).toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 14,
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

  Widget _buildCourseInput(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course ${index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF197E46),
                ),
              ),
              if (_courses.length > 2)
                IconButton(
                  onPressed: () => _removeCourse(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Remove Course',
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<double>(
                  value: _courses[index].credit,
                  decoration: const InputDecoration(
                    labelText: 'Credit',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _creditOptions.map((credit) {
                    return DropdownMenuItem(
                      value: credit,
                      child: Text(credit.toString()),
                    );
                  }).toList(),
                  onChanged: (value) => _updateCourse(index, value, null),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _courses[index].grade,
                  decoration: const InputDecoration(
                    labelText: 'Grade',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _gradeOptions.keys.map((grade) {
                    return DropdownMenuItem(
                      value: grade,
                      child: Text('$grade (${_gradeOptions[grade]})'),
                    );
                  }).toList(),
                  onChanged: (value) => _updateCourse(index, null, value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseInput {
  double credit;
  String grade;

  CourseInput({
    required this.credit,
    required this.grade,
  });
}
