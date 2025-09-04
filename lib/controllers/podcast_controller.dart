import 'package:get/get.dart';
import '../models/episode_model.dart';
import '../services/podcast_service.dart';

class PodcastController extends GetxController {
  final PodcastService _podcastService = PodcastService();
  
  // Observable variables
  var episodes = <EpisodeModel>[].obs;
  var isLoading = false.obs;
  var selectedEpisode = Rxn<EpisodeModel>();
  
  int get currentIndex {
    if (selectedEpisode.value == null) return -1;
    return episodes.indexWhere((e) => e.id == selectedEpisode.value!.id);
  }
  
  @override
  void onInit() {
    super.onInit();
    loadEpisodes();
  }
  
  Future<void> loadEpisodes() async {
    try {
      isLoading.value = true;
      final episodeList = await _podcastService.getEpisodes();
      episodes.value = episodeList;
    } catch (e) {
      print('Error loading episodes: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void selectEpisode(EpisodeModel episode) {
    selectedEpisode.value = episode;
  }
  
  void selectByIndex(int index) {
    if (index < 0 || index >= episodes.length) return;
    selectedEpisode.value = episodes[index];
  }
  
  void selectNext() {
    if (episodes.isEmpty) return;
    if (currentIndex == -1) {
      selectedEpisode.value = episodes.first;
      return;
    }
    final next = (currentIndex + 1) % episodes.length;
    selectedEpisode.value = episodes[next];
  }
  
  void selectPrevious() {
    if (episodes.isEmpty) return;
    if (currentIndex == -1) {
      selectedEpisode.value = episodes.first;
      return;
    }
    final prev = (currentIndex - 1) < 0 ? episodes.length - 1 : currentIndex - 1;
    selectedEpisode.value = episodes[prev];
  }
  
  void clearSelection() {
    selectedEpisode.value = null;
  }
}
