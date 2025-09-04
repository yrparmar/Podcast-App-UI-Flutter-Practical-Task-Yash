import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/episode_model.dart';

class PodcastService {
  Future<List<EpisodeModel>> getEpisodes() async {
    try {
      // Load episodes from local JSON file
      final String response = await rootBundle.loadString('assets/data/episodes.json');
      final List<dynamic> data = json.decode(response);

      return data.map((json) => EpisodeModel.fromJson(json)).toList();
    } catch (e) {
      print('Error loading episodes: $e');
      // Return hardcoded episodes as fallback
      return _getHardcodedEpisodes();
    }
  }

  List<EpisodeModel> _getHardcodedEpisodes() {
    return [
      EpisodeModel(
        id: '1',
        title: 'Introduction to Flutter Development',
        description: 'Learn the basics of Flutter development and how to build your first app.',
        audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
        duration: const Duration(minutes: 2, seconds: 7),
        publishDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      EpisodeModel(
        id: '2',
        title: 'State Management with GetX',
        description: 'Understanding state management patterns and implementing GetX in your Flutter apps.',
        audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
        duration: const Duration(minutes: 2, seconds: 7),
        publishDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      EpisodeModel(
        id: '3',
        title: 'Building Responsive UIs',
        description: 'Creating beautiful and responsive user interfaces that work across all devices.',
        audioUrl: 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
        duration: const Duration(minutes: 2, seconds: 7),
        publishDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
