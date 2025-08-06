import 'package:flutter/material.dart';
import 'widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF197E46), // Deep green header
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white), // White icon
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white), // White icon
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greetings Box
              _buildGreetingsBox(),
              const SizedBox(height: 20),

              // Main Focus Boxes
              _buildMainFocusBoxes(),
              const SizedBox(height: 20),

              // Academic Tools
              _buildAcademicTools(),
              const SizedBox(height: 20),

              // Information Section
              _buildInformationSection(),
              const SizedBox(height: 20),

              // Websites Section
              _buildWebsitesSection(),
              const SizedBox(height: 30), // Extra padding at bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGreetingsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8), // Light green background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey John',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF197E46), // Dark green text for contrast
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Student ID: 2023-123-456',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF197E46), // Dark green text for contrast
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainFocusBoxes() {
    return Row(
      children: [
        Expanded(
          child: _buildFocusBox(
            'Canteen\nPre-order',
            Icons.restaurant,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildFocusBox(
            'Transport\nBooking',
            Icons.directions_bus,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusBox(String title, IconData icon) {
    return Container(
      height: 130, // Increased height to prevent overflow
      padding: const EdgeInsets.all(15), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35, // Slightly reduced icon size
            color: const Color(0xFF197E46), // Dark green icon
          ),
          const SizedBox(height: 8), // Reduced spacing
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13, // Slightly reduced font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF197E46), // Dark green text
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Academic Tools',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800], // Dark grey for better contrast
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.3, // Increased aspect ratio to prevent overflow
          children: [
            _buildToolBox('Tuition Fees\nCalculator', Icons.calculate),
            _buildToolBox('CGPA\nCalculator', Icons.grade),
            _buildToolBox('Attendance Mark\nCalculator', Icons.check_circle),
            _buildToolBox('Routine\nGenerator', Icons.schedule),
            _buildToolBox('Academic\nCalendar', Icons.calendar_today),
            _buildToolBox('Student\nPortal', Icons.person),
          ],
        ),
      ],
    );
  }

  Widget _buildToolBox(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28, // Slightly reduced icon size
            color: const Color(0xFF197E46), // Dark green icon
          ),
          const SizedBox(height: 6), // Reduced spacing
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11, // Slightly reduced font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF197E46), // Dark green text
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800], // Dark grey for better contrast
          ),
        ),
        const SizedBox(height: 15),
        _buildInfoItem('Campus Info', Icons.location_on),
        _buildInfoItem('Faculty Info', Icons.school),
        _buildInfoItem('Clubs Info', Icons.group),
        _buildInfoItem('Important Contacts', Icons.contact_phone),
      ],
    );
  }

  Widget _buildInfoItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF197E46), // Dark green icon
            size: 24,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF197E46), // Dark green text
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildWebsitesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Websites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800], // Dark grey for better contrast
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120, // Increased height for circular items
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildWebsiteCard('Official\nWebsite', Icons.language),
              _buildWebsiteCard('CSE\nDepartment', Icons.computer),
              _buildWebsiteCard('Software\nDepartment', Icons.code),
              _buildWebsiteCard('ADS\nDepartment', Icons.analytics),
              _buildWebsiteCard('EEE\nDepartment', Icons.electric_bolt),
              _buildWebsiteCard('Textile\nDepartment', Icons.style),
              _buildWebsiteCard('BBA\nDepartment', Icons.business),
              _buildWebsiteCard('English\nDepartment', Icons.book),
              _buildWebsiteCard('LLB\nDepartment', Icons.gavel),
              _buildWebsiteCard('Sociology\nDepartment', Icons.people),
              _buildWebsiteCard('Computer\nClub', Icons.computer),
              _buildWebsiteCard('IEEE', Icons.engineering),
              _buildWebsiteCard('Basis', Icons.group_work),
              _buildWebsiteCard('EEE\nClub', Icons.electric_bolt),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebsiteCard(String title, IconData icon) {
    return Container(
      width: 100, // Reduced width for circular format
      height: 100, // Fixed height for circular format
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle, // Circular format
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF197E46), // Dark green icon
            size: 24, // Reduced icon size for circular format
          ),
          const SizedBox(height: 4), // Reduced spacing
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10, // Smaller font size for circular format
              fontWeight: FontWeight.bold,
              color: Color(0xFF197E46), // Dark green text
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF197E46),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Club',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
} 