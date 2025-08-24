import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TransportInfoActivity extends StatefulWidget {
  const TransportInfoActivity({super.key});

  @override
  State<TransportInfoActivity> createState() => _TransportInfoActivityState();
}

class _TransportInfoActivityState extends State<TransportInfoActivity> {
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  List<Map<String, dynamic>> _bookings = [];
  Map<String, RouteStats> _routeStats = {};

  @override
  void initState() {
    super.initState();
    _loadBookingsForDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport Information'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadBookingsForDate(_selectedDate),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Selection Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
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
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF197E46),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Select Date:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF197E46)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF197E46),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Add a manual refresh button for the current date
                IconButton(
                  icon: const Icon(Icons.refresh, color: Color(0xFF197E46)),
                  onPressed: () => _loadBookingsForDate(_selectedDate),
                  tooltip: 'Refresh current date',
                ),
              ],
            ),
          ),
          
          // Summary Cards
          if (_routeStats.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _routeStats.values.map((stats) {
                      return _buildSummaryCard(stats);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          
          // Bookings List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF197E46)),
                    ),
                  )
                : _bookings.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_bus,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No bookings found for this date',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _bookings.length,
                        itemBuilder: (context, index) {
                          final booking = _bookings[index];
                          return _buildBookingCard(booking);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(RouteStats stats) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Text(
            stats.routeName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF197E46),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'Total: ${stats.totalBookings}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'AM: ${stats.morningBookings}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            'PM: ${stats.afternoonBookings}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final routeName = booking['routeName'] ?? 'Unknown Route';
    final userName = booking['userName'] ?? 'Unknown User';
    final userType = booking['userType'] ?? 'Unknown';
    final bookingType = booking['bookingType'] ?? 'Unknown';
    final status = booking['status'] ?? 'pending';
    
    String timeInfo = '';
    String scheduleInfo = '';
    
         if (bookingType == 'weekly') {
       final daySchedules = booking['daySchedules'];
       if (daySchedules != null && daySchedules is Map) {
         // Safely convert to Map<String, dynamic>
         final schedules = daySchedules.map<String, dynamic>(
           (key, value) => MapEntry(key.toString(), value),
         );
         
         // Show all selected days with their times
         final selectedDays = <String>[];
         for (var entry in schedules.entries) {
           if (entry.value is Map && entry.value['isSelected'] == true) {
             final day = entry.key;
             final startTime = entry.value['startTime']?.toString() ?? 'N/A';
             final departureTime = entry.value['departureTime']?.toString() ?? 'N/A';
             selectedDays.add('$day: $startTime - $departureTime');
           }
         }
         timeInfo = selectedDays.join('\n');
         scheduleInfo = 'Weekly Schedule';
       }
     } else {
      timeInfo = '${booking['startTime'] ?? 'N/A'} - ${booking['departureTime'] ?? 'N/A'}';
      scheduleInfo = 'Specific Date: ${booking['specificDate'] ?? 'N/A'}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF197E46).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.directions_bus,
                  color: const Color(0xFF197E46),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF197E46),
                      ),
                    ),
                    Text(
                      'User: $userName ($userType)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
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
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  timeInfo,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'Type: ${bookingType.toUpperCase()}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  scheduleInfo,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadBookingsForDate(_selectedDate);
    }
  }

  Future<void> _loadBookingsForDate(DateTime date) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final databaseRef = FirebaseDatabase.instance.ref();
      final bookingsRef = databaseRef.child('transport_bookings');
      
      final snapshot = await bookingsRef.get();
      
      if (snapshot.exists) {
        final allBookings = <Map<String, dynamic>>[];
        final routeStats = <String, RouteStats>{};
        
        for (var child in snapshot.children) {
          // Handle the type casting properly for Firebase data
          final rawValue = child.value;
          if (rawValue != null && rawValue is Map) {
            // Convert Map<Object?, Object?> to Map<String, dynamic>
            final booking = rawValue.map<String, dynamic>(
              (key, value) => MapEntry(key.toString(), value),
            );
            // Check if this booking is for the selected date
            bool isForSelectedDate = false;
            
            if (booking['bookingType'] == 'specific') {
              // Check specific date bookings using the new date structure
              if (booking['dateYear'] == date.year &&
                  booking['dateMonth'] == date.month &&
                  booking['dateDay'] == date.day) {
                isForSelectedDate = true;
              }
              // Fallback to old method if new structure doesn't exist
              if (!isForSelectedDate && booking['schedule'] != null) {
                final bookingDate = DateTime.tryParse(booking['schedule'][0] ?? '');
                if (bookingDate != null && 
                    bookingDate.year == date.year &&
                    bookingDate.month == date.month &&
                    bookingDate.day == date.day) {
                  isForSelectedDate = true;
                }
              }
                         } else if (booking['bookingType'] == 'weekly') {
               // For weekly bookings, check if the selected date matches any of the scheduled days
               final daySchedules = booking['daySchedules'];
               if (daySchedules != null && daySchedules is Map) {
                 // Safely convert to Map<String, dynamic>
                 final schedules = daySchedules.map<String, dynamic>(
                   (key, value) => MapEntry(key.toString(), value),
                 );
                 
                 final dayName = _getDayName(date.weekday);
                 if (schedules.containsKey(dayName) && 
                     schedules[dayName] is Map &&
                     schedules[dayName]['isSelected'] == true) {
                   isForSelectedDate = true;
                 }
               }
               // Fallback to old method if new structure doesn't exist
               if (!isForSelectedDate && booking['schedule'] != null) {
                 try {
                   final selectedDays = List<String>.from(booking['schedule']);
                   final dayName = _getDayName(date.weekday);
                   if (selectedDays.contains(dayName)) {
                     isForSelectedDate = true;
                   }
                 } catch (e) {
                   // Skip if schedule is not a valid list
                 }
               }
             }
            
            if (isForSelectedDate) {
              allBookings.add(booking);
              
              // Update route statistics
              final routeId = booking['routeId'] ?? 'unknown';
              final routeName = booking['routeName'] ?? 'Unknown Route';
              
              if (!routeStats.containsKey(routeId)) {
                routeStats[routeId] = RouteStats(
                  routeId: routeId,
                  routeName: routeName,
                  totalBookings: 0,
                  morningBookings: 0,
                  afternoonBookings: 0,
                );
              }
              
              routeStats[routeId]!.totalBookings++;
              
                             // Determine if it's morning or afternoon
               String? startTime;
               if (booking['bookingType'] == 'weekly') {
                 final daySchedules = booking['daySchedules'];
                 if (daySchedules != null && daySchedules is Map) {
                   // Safely convert to Map<String, dynamic>
                   final schedules = daySchedules.map<String, dynamic>(
                     (key, value) => MapEntry(key.toString(), value),
                   );
                   
                   final dayName = _getDayName(date.weekday);
                   if (schedules.containsKey(dayName) && schedules[dayName] is Map) {
                     final daySchedule = schedules[dayName] as Map;
                     startTime = daySchedule['startTime']?.toString();
                   }
                 }
               } else {
                 startTime = booking['startTime']?.toString();
               }
              
              if (startTime != null) {
                if (startTime.contains('AM')) {
                  routeStats[routeId]!.morningBookings++;
                } else if (startTime.contains('PM')) {
                  routeStats[routeId]!.afternoonBookings++;
                }
              }
            }
          }
        }
        
        setState(() {
          _bookings = allBookings;
          _routeStats = routeStats;
          _isLoading = false;
        });
      } else {
        setState(() {
          _bookings = [];
          _routeStats = {};
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load bookings: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}

class RouteStats {
  final String routeId;
  final String routeName;
  int totalBookings;
  int morningBookings;
  int afternoonBookings;

  RouteStats({
    required this.routeId,
    required this.routeName,
    required this.totalBookings,
    required this.morningBookings,
    required this.afternoonBookings,
  });
}
