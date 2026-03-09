# API Keys Setup

All API keys are managed via environment variables and injected at build time.

## Required Keys

| Variable                          | Service                | Where to get it                                      |
|-----------------------------------|------------------------|------------------------------------------------------|
| `DOCUSEAL_TOKEN`                  | DocuSeal e-signature   | [DocuSeal Dashboard](https://docuseal.com)           |
| `APIFLOW_TOKEN`                   | ApiFlow PDF generation | [ApiFlow Console](https://apiflow.online)            |
| `APIFLOW_URL`                     | ApiFlow endpoint       | ApiFlow Console -> API details                       |
| `GOOGLE_MAPS_KEY`                 | Google Maps            | [Google Cloud Console](https://console.cloud.google.com) |
| `RAPIDAPI_KEY`                    | RapidAPI Property Data | [RapidAPI Dashboard](https://rapidapi.com)           |
| `ONESIGNAL_APP_ID`                | OneSignal push         | [OneSignal Dashboard](https://onesignal.com)         |
| `FIREBASE_WEB_API_KEY`            | Firebase (web)         | Firebase Console -> Project settings -> Web app      |
| `FIREBASE_WEB_APP_ID`             | Firebase (web)         | Firebase Console -> Project settings -> Web app      |
| `FIREBASE_WEB_MESSAGING_SENDER_ID`| Firebase (web)         | Firebase Console -> Project settings                 |
| `FIREBASE_MEASUREMENT_ID`         | Firebase (web)         | Firebase Console -> Project settings                 |
| `FACEBOOK_APP_ID`                 | Facebook Login         | [Meta Developer Console](https://developers.facebook.com) |
| `FACEBOOK_CLIENT_TOKEN`           | Facebook Login         | Meta Developer Console -> App settings -> Advanced   |

## Local Development

1. Copy `.env.example` to `.env`
2. Fill in all values
3. Run: `flutter run --dart-define-from-file=.env`

## CI/CD

Add each variable as a GitHub Actions secret. The workflows automatically
inject them into `.env` at build time.

## Platform-Specific Notes

- **Android**: `google-services.json` is gitignored  download from Firebase Console
- **iOS**: `GoogleService-Info.plist` is gitignored  download from Firebase Console
- **iOS**: Google Maps key is read from `Info.plist` via `GOOGLE_MAPS_KEY` build variable
- **Android**: Facebook keys are in `android/app/src/main/res/values/strings.xml` (use placeholders)
