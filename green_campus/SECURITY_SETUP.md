# Security Setup Guide - Green Campus App

## 🔒 API Key Security Issue Resolution

This guide explains how to properly handle Firebase API keys and resolve GitHub security alerts.

## 🚨 Problem
GitHub detected exposed Google API keys in `lib/firebase_options.dart` which poses a security risk.

## ✅ Solution Implemented

### 1. Immediate Fix (Current State)
- Temporarily reverted to hardcoded keys to ensure app functionality
- App is now running successfully
- Firebase connection is working properly

### 2. Recommended Long-term Security Solutions

#### Option A: Firebase Security Rules (Recommended)
The most secure approach is to use Firebase Security Rules to restrict access:

```javascript
// In Firebase Console > Realtime Database > Rules
{
  "rules": {
    "users": {
      "$userType": {
        "$studentId": {
          ".read": "$studentId === auth.uid || root.child('users').child('Transport').child(auth.uid).exists()",
          ".write": "$studentId === auth.uid || root.child('users').child('Transport').child(auth.uid).exists()"
        }
      }
    },
    "transport_bookings": {
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}
```

#### Option B: Build-time Environment Variables
For production builds, use build-time environment variables:

**For Android:**
```gradle
// android/app/build.gradle
android {
    defaultConfig {
        resValue "string", "firebase_web_api_key", System.getenv("FIREBASE_WEB_API_KEY") ?: ""
    }
}
```

**For iOS:**
```swift
// ios/Runner/Info.plist
<key>FirebaseWebAPIKey</key>
<string>$(FIREBASE_WEB_API_KEY)</string>
```

#### Option C: Backend API Proxy
Create a backend service that handles Firebase operations:

```dart
// lib/services/api_service.dart
class ApiService {
  static const String baseUrl = 'https://your-backend.com/api';
  
  static Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    // Send request to your backend instead of directly to Firebase
  }
}
```

## 📋 Current Status

### ✅ Working Features
- App starts successfully
- Firebase connection established
- All functionality preserved
- Database operations working

### ⚠️ Security Considerations
- API keys are currently in source code (temporary)
- Need to implement one of the long-term solutions above
- Consider rotating API keys after implementing security

## 🔄 Next Steps

### Immediate Actions
1. ✅ App is working - continue development
2. ⚠️ Monitor Firebase usage for unusual activity
3. 🔄 Plan implementation of long-term security solution

### Long-term Security Implementation
1. **Choose a security approach** (A, B, or C above)
2. **Implement Firebase Security Rules** (Option A is easiest)
3. **Rotate API keys** after security is in place
4. **Test thoroughly** with new security measures

## 🛡️ Security Best Practices

1. **Use Firebase Security Rules** to restrict database access
2. **Monitor API usage** in Firebase Console
3. **Rotate API keys** regularly
4. **Use authentication** for sensitive operations
5. **Implement proper user roles** (Student, Teacher, Transport)

## 📞 Support

If you encounter issues:
1. Check Firebase Console for usage and errors
2. Verify database rules are properly configured
3. Test with different user types and permissions

## ⚠️ Important Notes

- The current setup works but needs security improvements
- Choose the security approach that best fits your deployment strategy
- Firebase Security Rules are the most effective protection
- Consider implementing user authentication for better security

## 🔧 Quick Security Enhancement

To immediately improve security, implement Firebase Security Rules:

1. Go to Firebase Console > Realtime Database > Rules
2. Replace the rules with the example above
3. Test with different user types
4. Monitor for any access issues

This will provide immediate protection even with the current API key setup.
