import 'package:get_it/get_it.dart';

import '../../../core/service/logger_service.dart';
import '../../cart/model/cart_model.dart';
import '../../cart/service/cart_service.dart';
import '../../order/service/order_service.dart';
import '../model/checkout_model.dart';

class CheckoutService {
  //
  final LoggerService _logger = GetIt.instance<LoggerService>();
  final CartService _cartService = GetIt.instance<CartService>();
  final OrderService _orderService = GetIt.instance<OrderService>();
  //
  CheckoutService();
  //
  Future<bool> validateCart(Cart cart) async {
    if (cart.items.isEmpty) {
      throw Exception('Cart is empty');
    }
    // Add more validation as needed
    return true;
  }

  Future<bool> validateShippingDetails(ShippingDetails details) async {
    if (details.fullName.isEmpty ||
        details.address.isEmpty ||
        details.city.isEmpty ||
        details.state.isEmpty ||
        details.postalCode.isEmpty ||
        details.phone.isEmpty) {
      throw Exception('All shipping details are required');
    }
    return true;
  }

  Future<bool> processPayment(CheckoutDetails checkoutDetails) async {
    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      _logger.i('Payment processed successfully');
      return true;
    } catch (e) {
      _logger.e('Payment processing failed:', [e, StackTrace.current]);
      rethrow;
    }
  }

  Future<void> completeCheckout(CheckoutDetails checkoutDetails) async {
    try {
      // Validate cart
      await validateCart(checkoutDetails.cart);

      // Validate shipping details
      await validateShippingDetails(checkoutDetails.shippingDetails);

      // Process payment
      final paymentSuccess = await processPayment(checkoutDetails);

      if (!paymentSuccess) {
        throw Exception('Payment failed');
      }

      // Create order
      await _orderService.createOrder(
        checkoutDetails.cart,
        checkoutDetails.shippingDetails,
        checkoutDetails.paymentMethod,
      );

      // Clear cart
      // In a real app, this would be persisted to backend
      _cartService.clearCart();

      _logger.i('Checkout completed successfully');
    } catch (e) {
      _logger.e('Checkout failed:', [e, StackTrace.current]);
      rethrow;
    }
  }
}
