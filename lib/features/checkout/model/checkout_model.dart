import '../../cart/model/cart_model.dart';

enum PaymentMethod { creditCard, bankTransfer, paypal }

class ShippingDetails {
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String phone;

  ShippingDetails({
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'address': address,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'phone': phone,
  };

  factory ShippingDetails.fromJson(Map<String, dynamic> json) {
    return ShippingDetails(
      fullName: json['fullName'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      phone: json['phone'] as String,
    );
  }
}

class CheckoutDetails {
  final Cart cart;
  final ShippingDetails shippingDetails;
  final PaymentMethod paymentMethod;
  final double shippingCost;
  final double tax;

  CheckoutDetails({
    required this.cart,
    required this.shippingDetails,
    required this.paymentMethod,
    this.shippingCost = 10.0,
    this.tax = 0.1,
  });

  double get subtotal => cart.totalAmount;
  double get taxAmount => subtotal * tax;
  double get total => subtotal + taxAmount + shippingCost;

  Map<String, dynamic> toJson() => {
    'cart': cart.toJson(),
    'shippingDetails': shippingDetails.toJson(),
    'paymentMethod': paymentMethod.toString(),
    'shippingCost': shippingCost,
    'tax': tax,
    'total': total,
  };
}
