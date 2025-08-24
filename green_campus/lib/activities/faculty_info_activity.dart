import 'package:flutter/material.dart';

class FacultyInfoActivity extends StatefulWidget {
  const FacultyInfoActivity({super.key});

  @override
  State<FacultyInfoActivity> createState() => _FacultyInfoActivityState();
}

class _FacultyInfoActivityState extends State<FacultyInfoActivity>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<DepartmentInfo> departments = [
    DepartmentInfo(
      shortName: 'CSE',
      fullName: 'Dept. of Computer Science and Engineering',
      color: Colors.blue,
      faculty: [
        FacultyMember(
          name: 'Prof. Dr. Md. Saiful Azad',
          designation: 'Professor and Dean, FSE',
          email: 'dean@fse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Professor Dr. Md. Ahsan Habib',
          designation: 'Professor',
          email: 'mahabib@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Mr. Syed Ahsanul Kabir',
          designation: 'Associate Chairperson of CSE & Associate Professor',
          email: 'kabir@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Dr. Faiz Al Faisal',
          designation: 'Associate Professor & Director of IT',
          email: 'faisal@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Ms. Shamima Akter',
          designation: 'Assistant Professor',
          email: 'shamima_akter@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Md. Solaiman Mia',
          designation: 'Assistant Professor and Deputy Director of Student Affairs',
          email: 'solaiman@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Mr. Humayan Kabir Rana',
          designation: 'Senior Lecturer',
          email: 'humayan@cse.green.edu.bd',
        ),

        FacultyMember(
          name: 'Mr. Montaser Abdul Quader',
          designation: 'Lecturer',
          email: 'montaser@cse.green.edu.bd',
        ),
      ],
    ),
    DepartmentInfo(
      shortName: 'EEE',
      fullName: 'Dept. of Electrical and Electronic Engineering',
      color: Colors.orange,
      faculty: [
        FacultyMember(
          name: 'Prof. Dr. Md. Nurul Huda',
          designation: 'Professor & Head',
          email: 'head.eee@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Md. Rezaul Karim',
          designation: 'Associate Professor',
          email: 'rezaul.eee@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Nasreen Akter',
          designation: 'Assistant Professor',
          email: 'nasreen.eee@green.edu.bd',
        ),
      ],
    ),
    DepartmentInfo(
      shortName: 'Tex',
      fullName: 'Dept. of Textile Engineering',
      color: Colors.teal,
      faculty: [
        FacultyMember(
          name: 'Prof. Dr. Md. Abul Kalam',
          designation: 'Professor & Head',
          email: 'head.textile@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Fatema Khatun',
          designation: 'Associate Professor',
          email: 'fatema.textile@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Md. Kamrul Hasan',
          designation: 'Assistant Professor',
          email: 'kamrul.textile@green.edu.bd',
        ),
      ],
    ),
    DepartmentInfo(
      shortName: 'GBS',
      fullName: 'Green Business School',
      color: Colors.red,
      faculty: [
        FacultyMember(
          name: 'Prof. Dr. Md. Shahidul Islam',
          designation: 'Dean & Professor',
          email: 'dean.gbs@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Nasreen Sultana',
          designation: 'Associate Professor',
          email: 'nasreen.gbs@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Md. Rashedul Karim',
          designation: 'Assistant Professor',
          email: 'rashedul.gbs@green.edu.bd',
        ),
      ],
    ),
    DepartmentInfo(
      shortName: 'LLB',
      fullName: 'Dept. of Law',
      color: Colors.brown,
      faculty: [
        FacultyMember(
          name: 'Prof. Dr. Md. Shahidul Islam',
          designation: 'Professor & Head',
          email: 'head.law@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Fatema Khatun',
          designation: 'Associate Professor',
          email: 'fatema.law@green.edu.bd',
        ),
        FacultyMember(
          name: 'Dr. Md. Kamrul Hasan',
          designation: 'Assistant Professor',
          email: 'kamrul.law@green.edu.bd',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: departments.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Information'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: departments.map((dept) {
            return Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  dept.shortName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: departments.map((dept) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Department Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: dept.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: dept.color),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: dept.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              dept.shortName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              dept.fullName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dept.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Faculty List
                ...dept.faculty.map((member) => _buildFacultyCard(member, dept.color)).toList(),
                
                const SizedBox(height: 20),
                
                // Contact Information
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
                            Icons.contact_phone,
                            color: Colors.blue.shade700,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Department Contact Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'For ${dept.shortName} department inquiries:\n'
                        'Email: ${dept.shortName.toLowerCase()}@green.edu.bd\n'
                        'Phone: +880-2-9122565\n\n'
                        'Office Hours: Sunday-Thursday, 9:00 AM - 5:00 PM',
                        style: const TextStyle(
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
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFacultyCard(FacultyMember member, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Faculty Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.person,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF197E46),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  member.designation,
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        member.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: color,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentInfo {
  final String shortName;
  final String fullName;
  final Color color;
  final List<FacultyMember> faculty;

  DepartmentInfo({
    required this.shortName,
    required this.fullName,
    required this.color,
    required this.faculty,
  });
}

class FacultyMember {
  final String name;
  final String designation;
  final String email;

  FacultyMember({
    required this.name,
    required this.designation,
    required this.email,
  });
}
