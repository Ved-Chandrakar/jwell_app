import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/models/cart_item_model.dart';
import 'sales_controller.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  
  final double taxRate = 0.10; // 10% tax rate

  /// Add product to cart
  void addToCart(Product product, {int quantity = 1}) {
    // Check if product already exists in cart
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (index != -1) {
      // Update quantity if product already exists
      cartItems[index].quantity += quantity;
    } else {
      // Add new item to cart
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    
    Get.snackbar(
      'Success',
      '${product.title} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Remove product from cart
  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    
    Get.snackbar(
      'Removed',
      'Item removed from cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Update quantity of a cart item
  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }
    
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      cartItems[index].quantity = newQuantity;
    }
  }

  /// Increment quantity
  void incrementQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      cartItems[index].quantity++;
    }
  }

  /// Decrement quantity
  void decrementQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        removeFromCart(productId);
      }
    }
  }

  /// Clear cart
  void clearCart() {
    cartItems.clear();
  }

  /// Get total number of items in cart
  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get subtotal
  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Get tax amount
  double get taxAmount {
    return subtotal * taxRate;
  }

  /// Get total amount (subtotal + tax)
  double get total {
    return subtotal + taxAmount;
  }

  /// Check if cart is empty
  bool get isEmpty => cartItems.isEmpty;

  /// Process checkout (called after successful payment)
  Future<void> processCheckout() async {
    try {
      // Update sales data
      final salesController = Get.find<SalesController>();
      
      final salesData = cartItems.map((item) => {
        'productName': item.product.title,
        'quantity': item.quantity,
      }).toList();
      
      await salesController.updateSalesFromCart(salesData);
      
      // Clear cart
      clearCart();
      
      Get.snackbar(
        'Order Confirmed',
        'Thank you for your purchase!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process order: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
