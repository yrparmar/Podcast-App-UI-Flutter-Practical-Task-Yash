import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_controller.dart';
import '../controllers/podcast_controller.dart';
import '../constants/app_constants.dart';
import '../widgets/cover_image.dart';
import '../controllers/theme_controller.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());
    final PodcastController podcastController = Get.find<PodcastController>();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Player Screen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: Icon(Get.find<ThemeController>().isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => Get.find<ThemeController>().toggleTheme(),
            ),
          ],
        ),
      body: Obx(() {
        final episode = podcastController.selectedEpisode.value;
        if (episode == null) {
          return const Center(
            child: Text('No episode selected'),
          );
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              const CoverImage(width: 260, height: 260, borderRadius: 16),
              const SizedBox(height: 30),
              
              // Episode Title
              Text(
                episode.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // Episode Description
              Text(
                episode.description,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 30),
              
              // Progress Bar
              Obx(() {
                final position = audioController.currentPosition.value;
                final duration = audioController.duration.value;
                
                return Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.pink, Colors.orange], // your gradient colors
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Slider(
                        value: duration.inMilliseconds > 0
                            ? position.inMilliseconds / duration.inMilliseconds
                            : 0.0,
                        onChanged: (value) {
                          final newPosition = Duration(
                            milliseconds: (value * duration.inMilliseconds).round(),
                          );
                          audioController.seekTo(newPosition);
                        },
                        activeColor: Colors.white,   // keep white, ShaderMask overrides this
                        inactiveColor: Colors.white24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 30),
              
              // Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Speed Control
                  Obx(() => DropdownButton<double>(
                    value: audioController.playbackSpeed.value,
                    items: AppConstants.playbackSpeeds.map((speed) {
                      return DropdownMenuItem<double>(
                        value: speed,
                        child: Text('${speed}x'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        audioController.setPlaybackSpeed(value);
                      }
                    },
                    underline: const SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(12),
                  )),
                  
                  // Previous
                  IconButton(
                    iconSize: 32,
                    color: Colors.white,
                    onPressed: () {
                      podcastController.selectPrevious();
                      final updated = podcastController.selectedEpisode.value;
                      if (updated != null) {
                        audioController.loadAndPlay(updated.audioUrl);
                      }
                    },
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),

                  // Play/Pause Button
                  Obx(() => FloatingActionButton(
                    onPressed: () {
                      if (audioController.audioPlayer.audioSource == null) {
                        audioController.loadAudio(episode.audioUrl);
                      }
                      audioController.playPause();
                    },
                    backgroundColor: const Color(AppConstants.primaryPurple),
                    child: Icon(
                      audioController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  )),

                  // Next
                  IconButton(
                    iconSize: 32,
                    color: Colors.white,
                    onPressed: () {
                      podcastController.selectNext();
                      final updated = podcastController.selectedEpisode.value;
                      if (updated != null) {
                        audioController.loadAndPlay(updated.audioUrl);
                      }
                    },
                    icon: const Icon(Icons.skip_next_rounded),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      ),
    );
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
