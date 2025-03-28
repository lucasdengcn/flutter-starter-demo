import '../../../global/services/navigation_service.dart';
import '../../../global/viewmodels/base_viewmodel.dart';
import '../services/auth_service.dart';

enum SignupStep { phoneInput, otpVerification, nameInput, completed }

class SignupViewModel extends BaseViewModel {
  final AuthService _authService;
  final NavigationService _navigationService;

  SignupViewModel({
    required AuthService authService,
    required NavigationService navigationService,
  }) : _authService = authService,
       _navigationService = navigationService;

  String _phoneNumber = '';
  String _otp = '';
  String _name = '';
  SignupStep _currentStep = SignupStep.phoneInput;
  String _errorMessage = '';
  bool _isLoading = false;

  // Getters
  String get phoneNumber => _phoneNumber;
  String get otp => _otp;
  String get name => _name;
  SignupStep get currentStep => _currentStep;
  @override
  String get errorMessage => _errorMessage;
  @override
  bool get isLoading => _isLoading;

  // Setters with validation
  void setPhoneNumber(String value) {
    _phoneNumber = value.trim();
    _errorMessage = '';
    notifyListeners();
  }

  void setOTP(String value) {
    _otp = value.trim();
    _errorMessage = '';
    notifyListeners();
  }

  void setName(String value) {
    _name = value.trim();
    _errorMessage = '';
    notifyListeners();
  }

  // Phone number validation
  bool isValidPhoneNumber() {
    return _phoneNumber.length >= 10 && int.tryParse(_phoneNumber) != null;
  }

  // Send OTP
  Future<bool> sendOTP() async {
    if (!isValidPhoneNumber()) {
      _errorMessage = 'Please enter a valid phone number';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      bool success = await _authService.sendOTP(_phoneNumber);
      if (success) {
        _currentStep = SignupStep.otpVerification;
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to send OTP. Please try again.';
      }
      return success;
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify OTP
  Future<bool> verifyOTP() async {
    if (_otp.length != 6) {
      _errorMessage = 'Please enter a valid 6-digit OTP';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      bool success = await _authService.verifyOTP(_phoneNumber, _otp);
      if (success) {
        _currentStep = SignupStep.nameInput;
        _errorMessage = '';
      } else {
        _errorMessage = 'Invalid OTP. Please try again.';
      }
      return success;
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Complete signup
  Future<bool> completeSignup() async {
    if (_name.trim().isEmpty) {
      _errorMessage = 'Please enter your name';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      bool success = await _authService.createUserProfile(_phoneNumber, _name);
      if (success) {
        _currentStep = SignupStep.completed;
        _errorMessage = '';
        // navigateToPrayerScreen();
      } else {
        _errorMessage = 'Failed to create profile. Please try again.';
      }
      return success;
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset state
  void reset() {
    _phoneNumber = '';
    _otp = '';
    _name = '';
    _currentStep = SignupStep.phoneInput;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }

  // Navigate to prayer screen
  void navigateToPrayerScreen() {
    _navigationService.navigateTo('prayer');
  }
}
