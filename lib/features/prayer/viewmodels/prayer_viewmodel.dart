import '../../../global/viewmodels/base_viewmodel.dart';
import '../models/prayer_time.dart';
import '../services/prayer_service.dart';

enum PrayerViewState { initial, loading, loaded, error }

class PrayerViewModel extends BaseViewModel {
  final PrayerService _prayerService;
  PrayerViewState _state = PrayerViewState.initial;

  PrayerViewModel({required PrayerService prayerService})
    : _prayerService = prayerService {
    _initializePrayerTimes();
  }

  List<PrayerTime> _prayerTimes = [];
  String _selectedLocation = 'Jakarta, Indonesia';
  bool _isPrayerNotificationEnabled = true;
  String _nextPrayerName = '';
  final String _nextPrayerCountdown = '';

  PrayerViewState get state => _state;
  void _setState(PrayerViewState newState) {
    _state = newState;
    notifyListeners();
  }

  List<PrayerTime> get prayerTimes => _prayerTimes;
  String get selectedLocation => _selectedLocation;
  bool get isPrayerNotificationEnabled => _isPrayerNotificationEnabled;
  String get nextPrayerName => _nextPrayerName;
  String get nextPrayerCountdown => _nextPrayerCountdown;

  Future<void> _initializePrayerTimes() async {
    await refreshPrayerTimes();
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
      _nextPrayerName = await _prayerService.getNextPrayerTime();
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
}
