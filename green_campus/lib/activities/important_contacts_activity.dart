import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantContactsActivity extends StatelessWidget {
  const ImportantContactsActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Important Contacts'),
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
                    Icons.contact_phone,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Important Contacts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Get in touch with university offices and personnel',
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
            
            // Administrative Offices
            _buildContactSection(
              'Administrative Offices',
              [
                ContactInfo(
                  name: 'Vice Chancellor',
                  title: 'Prof. Dr. Md. Golam Samdani Fakir',
                  phone: '+880-2-9122565',
                  email: 'vc@green.edu.bd',
                  icon: Icons.person,
                  color: Colors.blue,
                ),
                ContactInfo(
                  name: 'Registrar',
                  title: 'Office of the Registrar',
                  phone: '+880-2-9122565',
                  email: 'registrar@green.edu.bd',
                  icon: Icons.work,
                  color: Colors.green,
                ),
                ContactInfo(
                  name: 'Controller of Examinations',
                  title: 'Examination Controller Office',
                  phone: '+880-2-9122565',
                  email: 'controller.exam@green.edu.bd',
                  icon: Icons.assignment,
                  color: Colors.orange,
                ),
                ContactInfo(
                  name: 'Director of Student Affairs',
                  title: 'Student Affairs Office',
                  phone: '+880-2-9122565',
                  email: 'director.af@green.edu.bd',
                  icon: Icons.people,
                  color: Colors.purple,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Academic Departments
            _buildContactSection(
              'Academic Departments',
              [
                ContactInfo(
                  name: 'Computer Science & Engineering',
                  title: 'CSE Department Office',
                  phone: '+880-2-9122565',
                  email: 'cse@green.edu.bd',
                  icon: Icons.computer,
                  color: Colors.indigo,
                ),
                ContactInfo(
                  name: 'Electrical & Electronic Engineering',
                  title: 'EEE Department Office',
                  phone: '+880-2-9122565',
                  email: 'eee@green.edu.bd',
                  icon: Icons.electric_bolt,
                  color: Colors.amber,
                ),
                ContactInfo(
                  name: 'Textile Engineering',
                  title: 'Textile Department Office',
                  phone: '+880-2-9122565',
                  email: 'textile@green.edu.bd',
                  icon: Icons.style,
                  color: Colors.teal,
                ),
                ContactInfo(
                  name: 'Green Business School',
                  title: 'GBS Office',
                  phone: '+880-2-9122565',
                  email: 'gbs@green.edu.bd',
                  icon: Icons.business,
                  color: Colors.red,
                ),
                ContactInfo(
                  name: 'English Department',
                  title: 'English Department Office',
                  phone: '+880-2-9122565',
                  email: 'english@green.edu.bd',
                  icon: Icons.book,
                  color: Colors.pink,
                ),
                ContactInfo(
                  name: 'Law Department',
                  title: 'LLB Department Office',
                  phone: '+880-2-9122565',
                  email: 'law@green.edu.bd',
                  icon: Icons.gavel,
                  color: Colors.brown,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Support Services
            _buildContactSection(
              'Support Services',
              [
                ContactInfo(
                  name: 'IT Support',
                  title: 'Information Technology Office',
                  phone: '+880-2-9122565',
                  email: 'it@green.edu.bd',
                  icon: Icons.support_agent,
                  color: Colors.cyan,
                ),
                ContactInfo(
                  name: 'Library',
                  title: 'Central Library',
                  phone: '+880-2-9122565',
                  email: 'library@green.edu.bd',
                  icon: Icons.library_books,
                  color: Colors.deepOrange,
                ),
                ContactInfo(
                  name: 'Transport',
                  title: 'Transport Office',
                  phone: '+880-2-9122565',
                  email: 'transport@green.edu.bd',
                  icon: Icons.directions_bus,
                  color: Colors.lime,
                ),
                ContactInfo(
                  name: 'Canteen',
                  title: 'Canteen Management',
                  phone: '+880-2-9122565',
                  email: 'canteen@green.edu.bd',
                  icon: Icons.restaurant,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Emergency Contacts
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
                        Icons.emergency,
                        color: Colors.red.shade700,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Emergency Contacts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildEmergencyContact('Campus Security', '+880-2-9122565'),
                  _buildEmergencyContact('Medical Emergency', '+880-2-9122565'),
                  _buildEmergencyContact('Fire Emergency', '+880-2-9122565'),
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
                    'Main Switchboard: +880-2-9122565\n'
                    'Fax: +880-2-9122565\n'
                    'Website: www.green.edu.bd\n'
                    'Address: 220/D, Begum Rokeya Sarani, Dhaka-1207, Bangladesh',
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

  Widget _buildContactSection(String title, List<ContactInfo> contacts) {
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
        ...contacts.map((contact) => _buildContactCard(contact)).toList(),
      ],
    );
  }

  Widget _buildContactCard(ContactInfo contact) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: contact.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  contact.icon,
                  color: contact.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF197E46),
                      ),
                    ),
                    Text(
                      contact.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildContactRow(Icons.phone, contact.phone, () => _makePhoneCall(contact.phone)),
          const SizedBox(height: 8),
          _buildContactRow(Icons.email, contact.email, () => _sendEmail(contact.email)),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF197E46),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF197E46),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String title, String phone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.phone,
            color: Colors.red.shade700,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          InkWell(
            onTap: () => _makePhoneCall(phone),
            child: Text(
              phone,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _sendEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}

class ContactInfo {
  final String name;
  final String title;
  final String phone;
  final String email;
  final IconData icon;
  final Color color;

  ContactInfo({
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
    required this.icon,
    required this.color,
  });
}
