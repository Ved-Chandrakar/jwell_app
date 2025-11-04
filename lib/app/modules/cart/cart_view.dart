import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../core/theme/app_theme.dart';
import '../payment/payment_service.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Obx(() {
            if (controller.cartItems.isNotEmpty) {
              return TextButton.icon(
                onPressed: () {
                  _showClearCartDialog(context);
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear'),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add some jewellery to get started',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Continue Shopping'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = controller.cartItems[index];
                  return _buildCartItemCard(context, cartItem);
                },
              ),
            ),
            
            // Cart Summary
            _buildCartSummary(context),
          ],
        );
      }),
    );
  }

  Widget _buildCartItemCard(BuildContext context, cartItem) {
    final product = cartItem.product;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Quantity Controls
                  Row(
                    children: [
                      // Decrement
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove, size: 16),
                          onPressed: () {
                            controller.decrementQuantity(product.id);
                          },
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      
                      // Quantity Display
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Increment
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add, size: 16),
                          onPressed: () {
                            controller.incrementQuantity(product.id);
                          },
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Item Total
                      Text(
                        '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppTheme.errorColor,
              onPressed: () {
                controller.removeFromCart(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Obx(() => Text(
                      '\$${controller.subtotal.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            
            // Tax
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax (${(controller.taxRate * 100).toInt()}%)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Obx(() => Text(
                      '\$${controller.taxAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ],
            ),
            const Divider(height: 24),
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Obx(() => Text(
                      '\$${controller.total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            
            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _proceedToCheckout(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _proceedToCheckout(BuildContext context) async {
    try {
      final paymentService = PaymentService();
      final amount = controller.total;
      
      // Show loading
      Get.dialog(
        const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Processing payment...'),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
      
      // Process payment
      final success = await paymentService.processPayment(amount);
      
      // Close loading dialog
      Get.back();
      
      if (success) {
        // Payment successful
        await controller.processCheckout();
        
        // Show success dialog
        Get.dialog(
          AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.successColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                const Text('Order Confirmed!'),
              ],
            ),
            content: const Text(
              'Thank you for your purchase. Your order has been placed successfully.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  Get.back(); // Go back to home
                },
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        );
      } else {
        // Payment failed
        Get.dialog(
          AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppTheme.errorColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                const Text('Payment Failed'),
              ],
            ),
            content: const Text(
              'There was an error processing your payment. Please try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      Get.back(); // Close loading if open
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showClearCartDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
