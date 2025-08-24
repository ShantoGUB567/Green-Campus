import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TransportBookingActivity extends StatefulWidget {
  final Map<String, dynamic> userData;
  
  const TransportBookingActivity({super.key, required this.userData});

  @override
  State<TransportBookingActivity> createState() => _TransportBookingActivityState();
}

class _TransportBookingActivityState extends State<TransportBookingActivity>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedRoute;
  Map<String, DaySchedule> _daySchedules = {};
  DateTime? _selectedDate;
  String? _selectedStartTime;
  String? _selectedDepartureTime;
  bool _isLoading = false;
  List<Map<String, dynamic>> _userBookings = [];
  bool _isLoadingBookings = false;

  final List<TransportRoute> _routes = [
    TransportRoute(
      id: '01',
      name: 'Shewrapara ➝ GUB (via Mirpur 12)',
      startTimes: ['07:00 AM', '09:00 AM'],
      departureTimes: ['04:45 PM', '01:45 PM'],
    ),
    TransportRoute(
      id: '02',
      name: 'Shewrapara ➝ GUB (via Mohakhali)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '03_1',
      name: 'Shyamoli ➝ GUB (via Majar Road)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '03_2',
      name: 'Shyamoli ➝ GUB (via Technical Mor)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '04_1',
      name: 'Azimpur ➝ GUB (via Dhanmondi 27 – Farmgate)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '05_1',
      name: 'Motijheel ➝ GUB (via Malibagh)',
      startTimes: ['07:00 AM'],
      departureTimes: ['01:45 PM'],
    ),
    TransportRoute(
      id: '05_2',
      name: 'Malibagh ➝ GUB (via Rampura)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '06_1',
      name: 'Gulistan ➝ GUB (via Staff Quarter)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '06_2',
      name: 'Jatrabari ➝ GUB (via Staff Quarter)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '07',
      name: 'Shonir Akhra ➝ GUB (via Kanchpur)',
      startTimes: ['07:00 AM'],
      departureTimes: ['01:45 PM'],
    ),
    TransportRoute(
      id: '08_1',
      name: 'Chashara ➝ GUB (via CTG Road)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '08_2',
      name: 'Chashara ➝ GUB (via Sign Board)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: 'mini',
      name: 'Rupganj (Rupshi) ➝ GUB (via Bhulta)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '09',
      name: 'Narsingdi ➝ GUB (via Bhulta)',
      startTimes: ['07:00 AM'],
      departureTimes: ['01:45 PM'],
    ),
    TransportRoute(
      id: '10_1',
      name: 'Gazipur Chowrasta ➝ GUB (via Abdullahpur)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '10_2',
      name: 'Abdullahpur ➝ GUB (via Uttara)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '11',
      name: 'Sonargaon ➝ GUB (via Madanpur – Noyapur)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '11/12',
      name: 'Sonargaon Baradi ➝ GUB (via Poraporde – Araihazar)',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '12',
      name: 'Araihazar (Bishnandi Ferry Ghat) ➝ GUB',
      startTimes: ['07:00 AM'],
      departureTimes: ['04:45 PM'],
    ),
    TransportRoute(
      id: '13',
      name: 'Kuril ➝ GUB (Shuttle Service)',
      startTimes: ['08:30 AM', '09:00 AM', '09:30 AM', '10:30 AM', '11:30 AM', '12:30 PM', '01:30 PM', '02:30 PM'],
      departureTimes: ['10:45 AM', '11:45 AM', '12:45 PM', '01:45 PM', '03:15 PM'],
    ),
    TransportRoute(
      id: '14',
      name: 'Gawsia ➝ GUB (Shuttle Service)',
      startTimes: ['08:30 AM', '09:00 AM', '09:30 AM', '10:30 AM', '11:30 AM', '12:30 PM', '01:30 PM', '02:30 PM'],
      departureTimes: ['10:45 AM', '11:45 AM', '12:45 PM', '01:45 PM', '03:15 PM'],
    ),
  ];

  final List<String> _weekDays = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Changed to 3 tabs
    
    // Initialize day schedules
    for (String day in _weekDays) {
      _daySchedules[day] = DaySchedule(
        day: day,
        isSelected: false,
        startTime: null,
        departureTime: null,
      );
    }
    
    // Load user's existing bookings
    _loadUserBookings();
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
        title: const Text('Transport Booking'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Weekly Schedule'),
            Tab(text: 'Specific Date'),
            Tab(text: 'My Bookings'), // New tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWeeklyScheduleTab(),
          _buildSpecificDateTab(),
          _buildMyBookingsTab(), // New tab content
        ],
      ),
    );
  }

  Widget _buildWeeklyScheduleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Selection
          _buildRouteSelection(),
          
          const SizedBox(height: 20),
          
          // Day Selection
          if (_selectedRoute != null) ...[
            _buildDaySelection(),
            const SizedBox(height: 20),
          ],
          
          // Time Selection for Selected Days
          if (_selectedRoute != null && _daySchedules.values.any((schedule) => schedule.isSelected)) ...[
            _buildWeeklyTimeSelection(),
            const SizedBox(height: 20),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveWeeklySchedule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF197E46),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Save Weekly Schedule',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecificDateTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Selection
          _buildRouteSelection(),
          
          const SizedBox(height: 20),
          
          // Date Selection
          Container(
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
                      Icons.calendar_today,
                      color: const Color(0xFF197E46),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: const Color(0xFF197E46),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select a date',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedDate != null ? Colors.grey[800] : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Time Selection
          if (_selectedRoute != null && _selectedDate != null) ...[
            _buildTimeSelection(),
            const SizedBox(height: 20),
            
            // Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _bookSpecificDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF197E46),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Book for Specific Date',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRouteSelection() {
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
                Icons.route,
                color: const Color(0xFF197E46),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Route',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField<String>(
            value: _selectedRoute,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF197E46), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            hint: const Text('Choose your route'),
            isExpanded: true, // This fixes the overflow issue
            items: _routes.map((route) {
              return DropdownMenuItem<String>(
                value: route.id,
                child: Text(
                  route.name,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRoute = value;
                _selectedStartTime = null;
                _selectedDepartureTime = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelection() {
    if (_selectedRoute == null) return const SizedBox.shrink();
    
    final selectedRoute = _routes.firstWhere((route) => route.id == _selectedRoute);
    
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
                Icons.access_time,
                color: const Color(0xFF197E46),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Times',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Start Time
          Text(
            'Start Time:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: selectedRoute.startTimes.map((time) {
              return ChoiceChip(
                label: Text(time),
                selected: _selectedStartTime == time,
                onSelected: (selected) {
                  setState(() {
                    _selectedStartTime = selected ? time : null;
                  });
                },
                selectedColor: const Color(0xFF197E46),
                labelStyle: TextStyle(
                  color: _selectedStartTime == time ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Departure Time
          Text(
            'Departure Time:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: selectedRoute.departureTimes.map((time) {
              return ChoiceChip(
                label: Text(time),
                selected: _selectedDepartureTime == time,
                onSelected: (selected) {
                  setState(() {
                    _selectedDepartureTime = selected ? time : null;
                  });
                },
                selectedColor: const Color(0xFF197E46),
                labelStyle: TextStyle(
                  color: _selectedDepartureTime == time ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelection() {
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
                Icons.calendar_view_week,
                color: const Color(0xFF197E46),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _weekDays.map((day) {
              return FilterChip(
                label: Text(day),
                selected: _daySchedules[day]?.isSelected ?? false,
                onSelected: (selected) {
                  setState(() {
                    _daySchedules[day]?.isSelected = selected;
                  });
                },
                selectedColor: const Color(0xFF197E46),
                labelStyle: TextStyle(
                  color: _daySchedules[day]?.isSelected ?? false ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTimeSelection() {
    if (_selectedRoute == null) return const SizedBox.shrink();

    final selectedRoute = _routes.firstWhere((route) => route.id == _selectedRoute);

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
                Icons.access_time,
                color: const Color(0xFF197E46),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Times for Selected Days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Start Time for Selected Days
          Text(
            'Start Time:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: selectedRoute.startTimes.map((time) {
              return ChoiceChip(
                label: Text(time),
                selected: _daySchedules.values.any((schedule) => schedule.isSelected && schedule.startTime == time),
                onSelected: (selected) {
                  setState(() {
                    for (var entry in _daySchedules.entries) {
                      if (entry.value.isSelected) {
                        entry.value.startTime = selected ? time : null;
                      }
                    }
                  });
                },
                selectedColor: const Color(0xFF197E46),
                labelStyle: TextStyle(
                  color: _daySchedules.values.any((schedule) => schedule.isSelected && schedule.startTime == time) ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Departure Time for Selected Days
          Text(
            'Departure Time:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: selectedRoute.departureTimes.map((time) {
              return ChoiceChip(
                label: Text(time),
                selected: _daySchedules.values.any((schedule) => schedule.isSelected && schedule.departureTime == time),
                onSelected: (selected) {
                  setState(() {
                    for (var entry in _daySchedules.entries) {
                      if (entry.value.isSelected) {
                        entry.value.departureTime = selected ? time : null;
                      }
                    }
                  });
                },
                selectedColor: const Color(0xFF197E46),
                labelStyle: TextStyle(
                  color: _daySchedules.values.any((schedule) => schedule.isSelected && schedule.departureTime == time) ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _bookWeeklySchedule() async {
    final selectedDays = _daySchedules.entries
        .where((entry) => entry.value.isSelected)
        .map((entry) => entry.key)
        .toList();
    
    if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one day'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _bookTransport('weekly', selectedDays);
  }

  Future<void> _bookSpecificDate() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedStartTime == null || _selectedDepartureTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both start and departure times'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _bookTransport('specific', [_selectedDate.toString()]);
  }

  Future<void> _saveWeeklySchedule() async {
    final selectedDays = _daySchedules.entries
        .where((entry) => entry.value.isSelected)
        .map((entry) => entry.key)
        .toList();
    
    if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one day'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check if all selected days have times
    for (var entry in _daySchedules.entries) {
      if (entry.value.isSelected && (entry.value.startTime == null || entry.value.departureTime == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select times for ${entry.value.day}'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    await _bookTransport('weekly', selectedDays);
  }

  Future<void> _bookTransport(String type, List<String> schedule) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final databaseRef = FirebaseDatabase.instance.ref();
      final bookingRef = databaseRef.child('transport_bookings').push();
      
      Map<String, dynamic> bookingData = {
        'userId': widget.userData['studentId'],
        'userType': widget.userData['userType'],
        'userName': widget.userData['fullName'],
        'routeId': _selectedRoute,
        'routeName': _routes.firstWhere((r) => r.id == _selectedRoute).name,
        'bookingType': type,
        'schedule': schedule,
        'status': 'pending',
        'createdAt': ServerValue.timestamp,
        'updatedAt': ServerValue.timestamp,
      };

      if (type == 'weekly') {
        // For weekly schedule, store individual day schedules with proper structure
        Map<String, Map<String, dynamic>> daySchedules = {};
        for (var entry in _daySchedules.entries) {
          if (entry.value.isSelected) {
            daySchedules[entry.value.day] = {
              'startTime': entry.value.startTime!,
              'departureTime': entry.value.departureTime!,
              'isSelected': true,
            };
          }
        }
        bookingData['daySchedules'] = daySchedules;
        // Also store the selected days list for easier querying
        bookingData['selectedDays'] = schedule;
      } else {
        // For specific date, store single time and date info
        bookingData['startTime'] = _selectedStartTime;
        bookingData['departureTime'] = _selectedDepartureTime;
        bookingData['specificDate'] = _selectedDate!.toIso8601String();
        // Store date components for easier querying
        bookingData['dateYear'] = _selectedDate!.year;
        bookingData['dateMonth'] = _selectedDate!.month;
        bookingData['dateDay'] = _selectedDate!.day;
      }
      
      await bookingRef.set(bookingData);

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transport booking ${type == 'weekly' ? 'scheduled' : 'booked'} successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Reset form
        setState(() {
          _selectedRoute = null;
          _selectedStartTime = null;
          _selectedDepartureTime = null;
          for (String day in _weekDays) {
            _daySchedules[day] = DaySchedule(
              day: day,
              isSelected: false,
              startTime: null,
              departureTime: null,
            );
          }
          _selectedDate = null;
        });
        
        // Reload user bookings to show the new booking
        _loadUserBookings();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book transport: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _loadUserBookings() async {
    setState(() {
      _isLoadingBookings = true;
    });
    try {
      final databaseRef = FirebaseDatabase.instance.ref();
      final bookingsRef = databaseRef.child('transport_bookings');
      
      final snapshot = await bookingsRef.get();
      if (snapshot.exists) {
        final allBookings = <Map<String, dynamic>>[];
        
        for (var child in snapshot.children) {
          // Handle the type casting properly for Firebase data
          final rawValue = child.value;
          if (rawValue != null) {
            // Convert the raw Firebase data to a proper Map<String, dynamic>
            Map<String, dynamic> booking;
            if (rawValue is Map) {
              // Convert Map<Object?, Object?> to Map<String, dynamic>
              booking = rawValue.map<String, dynamic>(
                (key, value) => MapEntry(key.toString(), value),
              );
            } else {
              continue; // Skip if not a map
            }
            
            // Check if this booking belongs to the current user
            if (booking['userId'] == widget.userData['studentId']) {
              // Add the booking key for reference
              booking['bookingKey'] = child.key;
              allBookings.add(booking);
            }
          }
        }
        
        setState(() {
          _userBookings = allBookings;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load bookings: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      setState(() {
        _isLoadingBookings = false;
      });
    }
  }

  Widget _buildMyBookingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isLoadingBookings)
            const Center(child: CircularProgressIndicator())
          else if (_userBookings.isEmpty)
            const Center(
              child: Text(
                'No transport bookings found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _userBookings.length,
              itemBuilder: (context, index) {
                                 final booking = _userBookings[index];
                 final bookingType = booking['bookingType'] as String;
                 final schedule = booking['schedule'] as List<dynamic>;
                 final routeName = booking['routeName'] as String;
                 final status = booking['status'] as String;
                 final createdAt = booking['createdAt'] as int;
                 final bookingId = booking['bookingKey'] as String;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.directions_bus,
                              color: const Color(0xFF197E46),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    routeName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF197E46),
                                    ),
                                  ),
                                  Text(
                                    'Route ID: ${booking['routeId']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Booking Type and Schedule
                        Row(
                          children: [
                            Icon(Icons.category, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Type: ${bookingType.toUpperCase()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        // Time Information
                        if (bookingType == 'weekly') ...[
                          Row(
                            children: [
                              Icon(Icons.schedule, color: Colors.grey[600], size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Weekly Schedule:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                                                     // Show detailed day schedules
                           if (booking['daySchedules'] != null) ...[
                             Container(
                               padding: const EdgeInsets.all(12),
                               decoration: BoxDecoration(
                                 color: Colors.grey[50],
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: Colors.grey[300]!),
                               ),
                               child: Column(
                                 children: _buildDayScheduleItems(booking['daySchedules']),
                               ),
                             ),
                           ],
                        ] else ...[
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.grey[600], size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Time: ${booking['startTime'] ?? 'N/A'} - ${booking['departureTime'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Date: ${booking['specificDate'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        const SizedBox(height: 16),
                        
                        // Created date
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Created: ${DateTime.fromMillisecondsSinceEpoch(createdAt).toLocal().toString().split('.')[0]}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (status == 'pending')
                              ElevatedButton(
                                onPressed: () => _updateBookingStatus(bookingId, 'confirmed'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Confirm'),
                              ),
                            if (status == 'pending')
                              ElevatedButton(
                                onPressed: () => _updateBookingStatus(bookingId, 'cancelled'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                            // Add delete button for all statuses
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _deleteBooking(bookingId),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _updateBookingStatus(String bookingId, String newStatus) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final databaseRef = FirebaseDatabase.instance.ref();
      final bookingRef = databaseRef.child('transport_bookings').child(bookingId);
      
      await bookingRef.update({'status': newStatus});

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking status updated to $newStatus'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 2),
          ),
        );
        _loadUserBookings(); // Reload bookings to show updated status
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update booking status: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _deleteBooking(String bookingId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final databaseRef = FirebaseDatabase.instance.ref();
      final bookingRef = databaseRef.child('transport_bookings').child(bookingId);
      
      await bookingRef.remove();

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking deleted successfully!'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        _loadUserBookings(); // Reload bookings to show updated list
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete booking: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildDayScheduleItems(dynamic daySchedules) {
    if (daySchedules == null) return [];
    
    try {
      // Safely convert to Map<String, dynamic>
      Map<String, dynamic> schedules;
      if (daySchedules is Map) {
        schedules = daySchedules.map<String, dynamic>(
          (key, value) => MapEntry(key.toString(), value),
        );
      } else {
        return [];
      }
      
      return schedules.entries
          .where((entry) => entry.value is Map && entry.value['isSelected'] == true)
          .map((entry) {
        final day = entry.key;
        final dayData = entry.value as Map;
        final startTime = dayData['startTime']?.toString() ?? 'N/A';
        final departureTime = dayData['departureTime']?.toString() ?? 'N/A';
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: const Color(0xFF197E46), size: 16),
              const SizedBox(width: 8),
              Text(
                '$day: $startTime - $departureTime',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList();
    } catch (e) {
      // Return empty list if there's any error
      return [];
    }
  }
}

class TransportRoute {
  final String id;
  final String name;
  final List<String> startTimes;
  final List<String> departureTimes;

  TransportRoute({
    required this.id,
    required this.name,
    required this.startTimes,
    required this.departureTimes,
  });
}

class DaySchedule {
  final String day;
  bool isSelected;
  String? startTime;
  String? departureTime;

  DaySchedule({
    required this.day,
    this.isSelected = false,
    this.startTime,
    this.departureTime,
  });
}
