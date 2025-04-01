import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/content_recommendation.dart';
import '../model/prayer_time.dart';
import '../service/content_recommendation_service.dart';
import '../service/prayer_service.dart';

enum PrayerViewState { initial, loading, loaded, error }

class PrayerViewModel extends BaseViewModel {
  final PrayerService _prayerService;
  final ContentRecommendationService _contentService;
  PrayerViewState _state = PrayerViewState.initial;

  PrayerViewModel({
    required PrayerService prayerService,
    required ContentRecommendationService contentService,
  }) : _prayerService = prayerService,
       _contentService = contentService {
    // _initializePrayerTimes();
  }

  List<PrayerTime> _prayerTimes = [];
  List<ContentRecommendation> _contentRecommendations = [];
  String _selectedLocation = 'Jakarta, Indonesia';
  bool _isPrayerNotificationEnabled = true;
  PrayerTime? _nextPrayer;
  String _nextPrayerCountdown = '';

  PrayerViewState get state => _state;
  void _setState(PrayerViewState newState) {
    _state = newState;
    notifyListeners();
  }

  List<PrayerTime> get prayerTimes => _prayerTimes;
  List<ContentRecommendation> get contentRecommendations =>
      _contentRecommendations;
  String get selectedLocation => _selectedLocation;
  bool get isPrayerNotificationEnabled => _isPrayerNotificationEnabled;
  PrayerTime? get nextPrayer => _nextPrayer;
  String get nextPrayerCountdown => _nextPrayerCountdown;

  void _updateNextPrayer() {
    if (_prayerTimes.isEmpty) {
      _nextPrayer = null;
      return;
    }

    final now = DateTime.now();
    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    for (final prayer in _prayerTimes) {
      if (prayer.time.compareTo(currentTime) > 0) {
        _nextPrayer = prayer;
        return;
      }
    }

    // If no next prayer found today, set to first prayer of next day
    _nextPrayer = _prayerTimes.first;
  }

  void _updateCountdown() {
    if (_nextPrayer == null) {
      _nextPrayerCountdown = '';
      return;
    }

    final now = DateTime.now();
    final nextPrayerTime = _parseTime(_nextPrayer!.time);
    if (nextPrayerTime.isBefore(now)) {
      nextPrayerTime.add(const Duration(days: 1));
    }

    final difference = nextPrayerTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    _nextPrayerCountdown = '${hours}h ${minutes}m';
    notifyListeners();
  }

  DateTime _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  Future<void> initializePrayerTimes() async {
    await Future.wait([refreshPrayerTimes(), loadContentRecommendations()]);
  }

  Future<void> togglePrayerNotification() async {
    try {
      _setState(PrayerViewState.loading);
      _isPrayerNotificationEnabled = !_isPrayerNotificationEnabled;
      await _prayerService.updatePrayerNotificationSettings(
        _isPrayerNotificationEnabled,
      );
      _setState(PrayerViewState.loaded);
    } catch (e) {
      setError(e.toString());
      _setState(PrayerViewState.error);
    }
  }

  Future<void> refreshPrayerTimes() async {
    try {
      _setState(PrayerViewState.loading);
      _prayerTimes = await _prayerService.getPrayerTimes(_selectedLocation);
      _updateNextPrayer();
      _setState(PrayerViewState.loaded);
    } catch (e) {
      setError(e.toString());
      _setState(PrayerViewState.error);
    }
  }

  void updateLocation(String newLocation) {
    _selectedLocation = newLocation;
    refreshPrayerTimes();
  }

  Future<void> loadContentRecommendations() async {
    try {
      _setState(PrayerViewState.loading);
      _contentRecommendations =
          await _contentService.getContentRecommendations();
      _setState(PrayerViewState.loaded);
    } catch (e) {
      setError(e.toString());
      _setState(PrayerViewState.error);
    }
  }

  Future<void> markContentAsViewed(String contentId) async {
    try {
      await _contentService.markContentAsViewed(contentId);
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> saveContentForLater(String contentId) async {
    try {
      await _contentService.saveContentForLater(contentId);
    } catch (e) {
      setError(e.toString());
    }
  }
}
