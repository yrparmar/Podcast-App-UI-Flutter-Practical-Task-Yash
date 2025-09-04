import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'episode_list_view.dart';
import '../constants/app_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());

    return Obx(() {
      final isDark = Get.find<ThemeController>().isDarkMode.value;
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(AppConstants.nightBlue),
                    Color(AppConstants.deepIndigo),
                  ]
                : const [
                    Color(AppConstants.lightStart),
                    Color(AppConstants.lightEnd),
                  ],
          ),
        ),
        child: const EpisodeListView(),
      );
    });
  }
}
