# Firebase Setup Guide

## ⚠️ Security Notice
This project contains sensitive Firebase API keys that should never be committed to version control.

## Setup Instructions

### 1. Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

### 2. Configure Firebase
```bash
flutterfire configure
```

This command will:
- Create a new `lib/firebase_options.dart` file with your actual API keys
- Configure Firebase for all platforms (Android, iOS, Web)

### 3. Verify Configuration
After running `flutterfire configure`, you should have:
- `lib/firebase_options.dart` (contains real API keys - DO NOT COMMIT)
- `lib/firebase_options.template.dart` (template file - safe to commit)

### 4. Firebase Console Setup
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing project
3. Add your apps (Android, iOS, Web)
4. Download configuration files if needed

## Security Best Practices

### ✅ Do's
- Keep `firebase_options.dart` in `.gitignore`
- Use environment variables for production
- Rotate API keys regularly
- Use Firebase Security Rules

### ❌ Don'ts
- Never commit `firebase_options.dart` to version control
- Don't share API keys publicly
- Don't use the same keys for development and production

## Environment Variables (Optional)

For additional security, you can use environment variables:

1. Create a `.env` file (add to .gitignore):
```
FIREBASE_API_KEY=your_api_key_here
FIREBASE_PROJECT_ID=your_project_id_here
```

2. Use `flutter_dotenv` package to load environment variables

## Troubleshooting

### If you accidentally committed API keys:
1. Immediately rotate the keys in Firebase Console
2. Remove the file from git history:
   ```bash
   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch lib/firebase_options.dart' --prune-empty --tag-name-filter cat -- --all
   ```
3. Force push to remove from remote repository:
   ```bash
   git push origin --force --all
   ```

### If the app doesn't work:
1. Ensure `lib/firebase_options.dart` exists
2. Verify API keys are correct
3. Check Firebase Console for any errors
4. Ensure Firebase project is properly configured

## Support
If you encounter issues, refer to the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview/).
