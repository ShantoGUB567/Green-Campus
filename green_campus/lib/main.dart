import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'attendance_mark_calculator.dart';
import 'cgpa_calculator.dart';
import 'tuition_fee_calculator.dart';
import 'test_connection.dart';
import 'activities/campus_info_activity.dart';
import 'activities/clubs_info_activity.dart';
import 'activities/important_contacts_activity.dart';
import 'activities/faculty_info_activity.dart';
import 'activities/academic_calendar_activity.dart';
import 'activities/student_portal_activity.dart';
import 'activities/profile_activity.dart';
import 'activities/transport_booking_activity.dart';
import 'activities/transport_info_activity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    // Configure Firebase Realtime Database URL
    FirebaseDatabase.instance.databaseURL = 'https://greencampus-949c7-default-rtdb.firebaseio.com/';
    
    print('Firebase initialized successfully');
    print('Database URL: ${FirebaseDatabase.instance.databaseURL}');
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Campus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        // Responsive theme settings
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      // Ensure the app is responsive
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.of(context).textScaler.clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.2,
            ),
          ),
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomeScreen(),
        '/attendance-mark': (context) => const AttendanceMarkCalculatorPage(),
        '/cgpa-calculator': (context) => const CGPACalculatorPage(),
        '/tuition-fee-calculator': (context) => const TuitionFeeCalculatorPage(),
        '/test-connection': (context) => const TestConnectionPage(),
        '/campus-info': (context) => const CampusInfoActivity(),
        '/clubs-info': (context) => const ClubsInfoActivity(),
        '/important-contacts': (context) => const ImportantContactsActivity(),
        '/faculty-info': (context) => const FacultyInfoActivity(),
        '/academic-calendar': (context) => const AcademicCalendarActivity(),
        '/student-portal': (context) => const StudentPortalActivity(),
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args != null && args is Map<String, dynamic>) {
            return ProfileActivity(userData: args);
          }
          return const Scaffold(
            body: Center(child: Text('Profile data not available')),
          );
        },
        '/transport-booking': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args != null && args is Map<String, dynamic>) {
            return TransportBookingActivity(userData: args);
          }
          return const Scaffold(
            body: Center(child: Text('User data not available')),
          );
        },
        '/transport-info': (context) => const TransportInfoActivity(),
      },
    );
  }
}
