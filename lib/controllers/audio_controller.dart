import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Observable variables
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var playbackSpeed = 1.0.obs;
  
  // Getters
  AudioPlayer get audioPlayer => _audioPlayer;
  
  @override
  void onInit() {
    super.onInit();
    _setupAudioPlayer();
  }
  
  void _setupAudioPlayer() {
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });
    
    _audioPlayer.durationStream.listen((audioDuration) {
      duration.value = audioDuration ?? Duration.zero;
    });
    
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }
  
  Future<void> playPause() async {
    if (isPlaying.value) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }
  
  Future<void> setPlaybackSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
    playbackSpeed.value = speed;
  }
  
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }
  
  Future<void> loadAudio(String url) async {
    try {
      await _audioPlayer.setUrl(url);
    } catch (e) {
      print('Error loading audio: $e');
    }
  }
  
  Future<void> loadAndPlay(String url) async {
    await loadAudio(url);
    await _audioPlayer.play();
  }
  
  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
