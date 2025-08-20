# Green Campus - Login & Registration System

## Overview
This document describes the new login and registration system implemented in the Green Campus Flutter application.

## Features Implemented

### 1. Login Page (`/login`)
- **User Type Selection**: Dropdown with options for Student, Teacher, Transport, and Canteen
- **ID Input**: Text field for user ID (minimum 3 characters)
- **Password Input**: Secure password field (minimum 6 characters)
- **Remember Me**: Checkbox option for user convenience
- **Forgot Password**: Link for future password recovery feature
- **Login Button**: Validates form and shows success message
- **Registration Link**: Navigation to registration page
- **Home Button**: Developer shortcut in top-right corner

### 2. Registration Page (`/register`)
- **User Type Selection**: Same dropdown options as login
- **Name Input**: Full name field (minimum 2 characters)
- **ID Input**: User ID field (minimum 3 characters)
- **Email Input**: Email address with validation
- **Phone Input**: Phone number field (minimum 10 digits)
- **Password Input**: Password field (minimum 6 characters)
- **Confirm Password**: Password confirmation with matching validation
- **Register Button**: Validates all fields and shows success message
- **Login Link**: Navigation back to login page
- **Home Button**: Developer shortcut in top-right corner

### 3. Navigation Flow
- **Splash Screen** → **Login Page** (after 4 seconds)
- **Login Page** → **Home Screen** (after successful login)
- **Login Page** → **Registration Page** (via register link)
- **Registration Page** → **Login Page** (after successful registration)
- **Home Screen** → **Login Page** (via logout button)

### 4. Additional Features
- **Logout Functionality**: Added to home screen app bar
- **Form Validation**: Comprehensive input validation with user-friendly error messages
- **Success Messages**: Toast notifications for successful operations
- **Responsive Design**: Consistent with existing app theme
- **Developer Tools**: Home button shortcuts for easy navigation during development

## Technical Details

### File Structure
```
lib/
├── login_page.dart          # Login page implementation
├── register_page.dart       # Registration page implementation
├── home_screen.dart         # Updated with logout functionality
├── splash_screen.dart       # Updated to navigate to login
└── main.dart               # Updated with new routes
```

### Routes
- `/` → SplashScreen
- `/login` → LoginPage
- `/register` → RegisterPage
- `/home` → HomeScreen
- `/attendance-mark` → AttendanceMarkCalculatorPage
- `/cgpa-calculator` → CGPACalculatorPage
- `/tuition-fee-calculator` → TuitionFeeCalculatorPage

### Form Validation Rules
- **User Type**: Required selection
- **Name**: Minimum 2 characters
- **ID**: Minimum 3 characters
- **Email**: Valid email format
- **Phone**: Minimum 10 digits
- **Password**: Minimum 6 characters
- **Confirm Password**: Must match password

### Color Scheme
- Primary: `#197E46` (Deep Green)
- Background: `#F5F5F5` (Light Grey)
- Text: Various shades of grey and green
- Success: Green
- Error: Red (via validation)

## Usage Instructions

### For Users
1. **First Time Users**: Navigate to registration page and create account
2. **Existing Users**: Use login page with credentials
3. **Logout**: Use logout button in home screen app bar

### For Developers
1. **Home Button**: Use the home button in top-right corner of login/register pages
2. **Navigation Testing**: Test all navigation flows between pages
3. **Form Validation**: Test all input validation scenarios

## Future Enhancements
- Password recovery functionality
- User profile management
- Session persistence
- Biometric authentication
- Multi-language support

## Testing
The application has been tested for:
- ✅ Form validation
- ✅ Navigation flows
- ✅ UI responsiveness
- ✅ Build compatibility
- ✅ Code analysis (no linting issues)

## Build Status
- **Flutter Analyze**: ✅ No issues found
- **Debug Build**: ✅ Successful APK generation
- **Dependencies**: ✅ All required packages included
