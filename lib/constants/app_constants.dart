class AppConstants {
  // App Information
  static const String appName = 'Podcast App';
  static const String appVersion = '1.0.0';
  
  // Brand Colors
  static const int primaryPurple = 0xFF6C49F6;
  static const int deepIndigo = 0xFF0E1231;
  static const int nightBlue = 0xFF12163E;
  static const int cardBlue = 0xFF1E2250;
  static const int accentPink = 0xFFFF3B92;

  // Light theme gradient
  static const int lightStart = 0xFFF7F8FF;
  static const int lightEnd = 0xFFE9ECFF;

  // Audio Settings
  static const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  static const double defaultPlaybackSpeed = 1.0;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Asset Paths
  static const String assetsPath = 'assets/';
  static const String imagesPath = '${assetsPath}images/';
  static const String dataPath = '${assetsPath}data/';
}
