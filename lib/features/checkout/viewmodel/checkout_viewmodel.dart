import 'package:get_it/get_it.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../cart/model/cart_model.dart';
import '../../cart/service/cart_service.dart';
import '../model/checkout_model.dart';
import '../service/checkout_service.dart';

class CheckoutViewModel extends BaseViewModel {
  //
  final CheckoutService _checkoutService = GetIt.I<CheckoutService>();
  final CartService _cartService = GetIt.I<CartService>();

  String fullName = '';
  String address = '';
  String city = '';
  String state = '';
  String postalCode = '';
  String phone = '';
  PaymentMethod paymentMethod = PaymentMethod.creditCard;

  Cart get cart => _cartService.currentCart ?? Cart();
  bool get hasItems => cart.items.isNotEmpty;
  double get subtotal => cart.totalAmount;
  double get tax => subtotal * 0.1;
  double get shippingCost => 10.0;
  double get total => subtotal + tax + shippingCost;

  Future<bool> completeCheckout(CheckoutDetails checkoutDetails) async {
    bool success = false;
    await handleAsyncOperation(() async {
      await _checkoutService.completeCheckout(checkoutDetails);
      success = true;
    });
    return success;
  }

  void updateField(String field, String value) {
    switch (field) {
      case 'fullName':
        fullName = value;
        break;
      case 'address':
        address = value;
        break;
      case 'city':
        city = value;
        break;
      case 'state':
        state = value;
        break;
      case 'postalCode':
        postalCode = value;
        break;
      case 'phone':
        phone = value;
        break;
    }
    notifyListeners();
  }

  void updatePaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    notifyListeners();
  }

  bool validateForm() {
    if (fullName.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        state.isEmpty ||
        postalCode.isEmpty ||
        phone.isEmpty) {
      setError('All fields are required');
      return false;
    }
    setError(null);
    return true;
  }

  Future<bool> submitCheckout() async {
    if (!validateForm()) return false;

    final shippingDetails = ShippingDetails(
      fullName: fullName,
      address: address,
      city: city,
      state: state,
      postalCode: postalCode,
      phone: phone,
    );

    final checkoutDetails = CheckoutDetails(
      cart: cart,
      shippingDetails: shippingDetails,
      paymentMethod: paymentMethod,
    );

    return completeCheckout(checkoutDetails);
  }
}
