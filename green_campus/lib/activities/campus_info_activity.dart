import 'package:flutter/material.dart';

class CampusInfoActivity extends StatelessWidget {
  const CampusInfoActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Information'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campus Overview
            _buildSection(
              'Campus Overview',
              'Green University of Bangladesh (GUB) is a private university located in Dhaka, Bangladesh. '
              'The university offers undergraduate and graduate programs in various fields including engineering, '
              'business, law, and humanities.',
              Icons.school,
            ),
            
            const SizedBox(height: 20),
            
            // Location
            _buildSection(
              'Location',
              'The university is situated in the heart of Dhaka city, providing easy access to students '
              'from all parts of the capital and surrounding areas.',
              Icons.location_on,
            ),
            
            const SizedBox(height: 20),
            
            // Facilities
            _buildSection(
              'Campus Facilities',
              '• Modern classrooms with multimedia facilities\n'
              '• Well-equipped laboratories\n'
              '• Library with extensive collection\n'
              '• Computer labs with latest technology\n'
              '• Cafeteria and food services\n'
              '• Transportation facilities\n'
              '• Sports and recreation areas',
              Icons.business,
            ),
            
            const SizedBox(height: 20),
            
            // Academic Programs
            _buildSection(
              'Academic Programs',
              'GUB offers a wide range of academic programs across multiple disciplines:\n\n'
              '• Engineering (CSE, EEE, Textile)\n'
              '• Business Administration\n'
              '• Law\n'
              '• English Language and Literature\n'
              '• And many more specialized programs',
              Icons.book,
            ),
            
            const SizedBox(height: 20),
            
            // Student Life
            _buildSection(
              'Student Life',
              'The university provides a vibrant campus life with various student organizations, '
              'clubs, and activities. Students can participate in cultural events, sports competitions, '
              'and academic conferences.',
              Icons.people,
            ),
            
            const SizedBox(height: 20),
            
            // Vision & Mission
            _buildSection(
              'Vision & Mission',
              'GUB is committed to providing quality education and fostering innovation, '
              'research, and community engagement. The university aims to prepare students '
              'for successful careers and responsible citizenship.',
              Icons.visibility,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF197E46),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF197E46),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
