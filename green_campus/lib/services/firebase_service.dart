import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Register a new user
  static Future<bool> registerUser({
    required String userType,
    required String fullName,
    required String nickname,
    required String studentId,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Check if user already exists
      final userExists = await _database
          .child('users')
          .child(userType)
          .child(studentId)
          .get();

      if (userExists.exists) {
        throw Exception('User with this ID already exists');
      }

      // Create user data
      final userData = {
        'fullName': fullName,
        'nickname': nickname,
        'studentId': studentId,
        'email': email,
        'phone': phone,
        'password': password,
        'userType': userType,
        'createdAt': ServerValue.timestamp,
      };

      // Save user data
      await _database
          .child('users')
          .child(userType)
          .child(studentId)
          .set(userData);

      return true;
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  // Login user
  static Future<Map<String, dynamic>?> loginUser({
    required String userType,
    required String studentId,
    required String password,
  }) async {
    try {
      final userSnapshot = await _database
          .child('users')
          .child(userType)
          .child(studentId)
          .get();

      if (!userSnapshot.exists) {
        throw Exception('User not found');
      }

      final userData = userSnapshot.value as Map<dynamic, dynamic>;
      
      if (userData['password'] != password) {
        throw Exception('Invalid password');
      }

      return {
        'fullName': userData['fullName'],
        'nickname': userData['nickname'],
        'studentId': userData['studentId'],
        'email': userData['email'],
        'phone': userData['phone'],
        'userType': userData['userType'],
      };
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  // Test database connection
  static Future<bool> testConnection() async {
    try {
      await _database.child('test').set({'timestamp': ServerValue.timestamp});
      await _database.child('test').remove();
      return true;
    } catch (e) {
      print('Database connection test failed: $e');
      return false;
    }
  }
}
