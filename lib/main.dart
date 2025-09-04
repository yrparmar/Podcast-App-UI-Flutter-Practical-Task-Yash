import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'controllers/podcast_controller.dart';
import 'views/home_view.dart';
import 'constants/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController(), permanent: true);
  Get.put(PodcastController(), permanent: true);
  runApp(const PodcastApp());
}

class PodcastApp extends StatelessWidget {
  const PodcastApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        title: 'Podcast App',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
          scaffoldBackgroundColor: const Color(0xFF0E1231),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppRoutes.home,
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => const HomeView(),
          ),
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
