import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';
import '../models/episode_model.dart';
import 'player_view.dart';
import '../widgets/cover_image.dart';
import '../constants/app_constants.dart';
import '../controllers/theme_controller.dart';

class EpisodeListView extends StatelessWidget {
  const EpisodeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final PodcastController controller = Get.find<PodcastController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('List Episode'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final isDark = Get.find<ThemeController>().isDarkMode.value;
            return IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => Get.find<ThemeController>().toggleTheme(),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.episodes.isEmpty) {
          return const Center(
            child: Text('No episodes available'),
          );
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CoverImage(width: 100, height: 100, borderRadius: 12),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Blockchain Experience',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Media3 Labs LLC',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Welcome to The Blockchain Experience, where we dive into the world of blockchain and web3...',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Available episodes',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark? Colors.white : Colors.black
                ,
              ),
            ),
            const SizedBox(height: 12),
            ...controller.episodes.map((e) => EpisodeCard(episode: e)).toList(),
          ],
        );
      }),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(AppConstants.cardBlue),
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.white.withOpacity(0.08)),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: const CoverImage(width: 60, height: 60, borderRadius: 8),
        ),
        title: Text(
          episode.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            const SizedBox(height: 4),
            Text(
              'Duration: ${_formatDuration(episode.duration)}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
            color: Colors.white.withOpacity(0.1),
          ),
          child: const Icon(Icons.play_arrow),
        ),
        onTap: () {
          Get.find<PodcastController>().selectEpisode(episode);
          Get.to(() => const PlayerView());
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}
