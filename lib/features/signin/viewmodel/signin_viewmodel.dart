import '../../../global/service/navigation_service.dart';
import '../../../global/viewmodel/base_viewmodel.dart';
import '../service/signin_auth_service.dart';

class SigninViewModel extends BaseViewModel {
  final SigninAuthService _authService;
  final NavigationService _navigationService;

  SigninViewModel({
    required SigninAuthService authService,
    required NavigationService navigationService,
  }) : _authService = authService,
       _navigationService = navigationService;

  String _phoneNumber = '';
  String _password = '';
  String _errorMessage = '';
  bool _isLoading = false;

  // Getters
  String get phoneNumber => _phoneNumber;
  String get password => _password;
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

  void setPassword(String value) {
    _password = value.trim();
    _errorMessage = '';
    notifyListeners();
  }

  // Phone number validation
  bool isValidPhoneNumber() {
    return _phoneNumber.length >= 10 && int.tryParse(_phoneNumber) != null;
  }

  // Sign in
  Future<bool> signin() async {
    if (!isValidPhoneNumber()) {
      _errorMessage = 'Please enter a valid phone number';
      notifyListeners();
      return false;
    }

    if (_password.isEmpty) {
      _errorMessage = 'Please enter your password';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // First check if phone number exists
      bool phoneExists = await _authService.checkPhoneNumberExists(
        _phoneNumber,
      );
      if (!phoneExists) {
        _errorMessage = 'Account not found. Please sign up first.';
        return false;
      }

      // Then authenticate
      bool success = await _authService.authenticateUser(
        _phoneNumber,
        _password,
      );
      if (success) {
        _errorMessage = '';
        navigateToPrayerScreen();
      } else {
        _errorMessage = 'Invalid credentials. Please try again.';
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

  // Navigate to prayer screen
  void navigateToPrayerScreen() {
    _navigationService.navigateToReplacement('prayer');
  }

  // Navigate to signup screen
  void navigateToSignupScreen() {
    _navigationService.navigateToReplacement('signup');
  }

  // Reset state
  void reset() {
    _phoneNumber = '';
    _password = '';
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}
