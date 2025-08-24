import 'package:flutter/material.dart';

class ClubsInfoActivity extends StatelessWidget {
  const ClubsInfoActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs & Organizations'),
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
                    Icons.group,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Student Clubs & Organizations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Join our vibrant community of student organizations',
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
            
            // Technical Clubs
            _buildClubSection(
              'Technical Clubs',
              [
                ClubInfo(
                  name: 'Green University Computer Club',
                  description: 'Promotes computer science and technology awareness among students. '
                  'Organizes coding competitions, workshops, and tech talks.',
                  icon: Icons.computer,
                  color: Colors.blue,
                ),
                ClubInfo(
                  name: 'IEEE Student Branch',
                  description: 'International organization for electrical and electronic engineering students. '
                  'Focuses on professional development and technical innovation.',
                  icon: Icons.electric_bolt,
                  color: Colors.orange,
                ),
                ClubInfo(
                  name: 'BASIS Student Forum',
                  description: 'Bangladesh Association of Software and Information Services student chapter. '
                  'Connects students with the IT industry.',
                  icon: Icons.work,
                  color: Colors.green,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Cultural & Social Clubs
            _buildClubSection(
              'Cultural & Social Clubs',
              [
                ClubInfo(
                  name: 'Debate Club',
                  description: 'Enhances public speaking and critical thinking skills. '
                  'Participates in national and international debate competitions.',
                  icon: Icons.record_voice_over,
                  color: Colors.purple,
                ),
                ClubInfo(
                  name: 'Cultural Club',
                  description: 'Promotes cultural activities, music, dance, and drama. '
                  'Organizes cultural festivals and performances.',
                  icon: Icons.music_note,
                  color: Colors.pink,
                ),
                ClubInfo(
                  name: 'Photography Club',
                  description: 'Develops photography skills and artistic vision. '
                  'Organizes photo exhibitions and workshops.',
                  icon: Icons.camera_alt,
                  color: Colors.indigo,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Sports & Recreation
            _buildClubSection(
              'Sports & Recreation',
              [
                ClubInfo(
                  name: 'Sports Club',
                  description: 'Promotes physical fitness and sportsmanship. '
                  'Organizes inter-university sports competitions.',
                  icon: Icons.sports_soccer,
                  color: Colors.red,
                ),
                ClubInfo(
                  name: 'Adventure Club',
                  description: 'Organizes outdoor activities, hiking, and adventure sports. '
                  'Promotes environmental awareness and team building.',
                  icon: Icons.terrain,
                  color: Colors.brown,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Academic & Professional
            _buildClubSection(
              'Academic & Professional',
              [
                ClubInfo(
                  name: 'Business Club',
                  description: 'Develops business acumen and entrepreneurial skills. '
                  'Organizes business case competitions and networking events.',
                  icon: Icons.business,
                  color: Colors.teal,
                ),
                ClubInfo(
                  name: 'Law Society',
                  description: 'Promotes legal awareness and professional development. '
                  'Organizes moot court competitions and legal workshops.',
                  icon: Icons.gavel,
                  color: Colors.amber,
                ),
                ClubInfo(
                  name: 'English Literary Society',
                  description: 'Enhances English language skills and literary appreciation. '
                  'Organizes poetry recitations and literary discussions.',
                  icon: Icons.book,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // How to Join
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.orange.shade700,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'How to Join',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '• Visit the Student Affairs Office\n'
                    '• Check notice boards for club announcements\n'
                    '• Attend club orientation sessions\n'
                    '• Contact club presidents or faculty advisors\n'
                    '• Participate in club activities and events',
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

  Widget _buildClubSection(String title, List<ClubInfo> clubs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF197E46),
          ),
        ),
        const SizedBox(height: 15),
        ...clubs.map((club) => _buildClubCard(club)).toList(),
      ],
    );
  }

  Widget _buildClubCard(ClubInfo club) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: club.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              club.icon,
              color: club.color,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF197E46),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  club.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClubInfo {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  ClubInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}
