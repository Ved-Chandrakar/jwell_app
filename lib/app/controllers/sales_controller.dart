import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SalesController extends GetxController {
  final RxMap<String, int> salesData = <String, int>{}.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSalesData();
  }

  /// Load sales data from SharedPreferences
  Future<void> loadSalesData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final salesJson = prefs.getString('sales_data');
      
      if (salesJson != null) {
        final Map<String, dynamic> decoded = json.decode(salesJson);
        salesData.value = decoded.map((key, value) => MapEntry(key, value as int));
      } else {
        // Initialize with dummy data
        _initializeDummyData();
        await saveSalesData();
      }
    } catch (e) {
      _initializeDummyData();
    } finally {
      isLoading.value = false;
    }
  }

  /// Initialize with dummy sales data
  void _initializeDummyData() {
    salesData.value = {
      'Gold Ring': 15,
      'Diamond Necklace': 8,
      'Silver Bracelet': 22,
      'Pearl Earrings': 12,
      'Platinum Chain': 6,
      'Gemstone Pendant': 10,
    };
  }

  /// Save sales data to SharedPreferences
  Future<void> saveSalesData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final salesJson = json.encode(salesData);
      await prefs.setString('sales_data', salesJson);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save sales data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Update sales data when a product is sold
  Future<void> updateSales(String productName, int quantity) async {
    // Use first 2-3 words of product name as key
    final key = _getProductKey(productName);
    
    if (salesData.containsKey(key)) {
      salesData[key] = (salesData[key] ?? 0) + quantity;
    } else {
      salesData[key] = quantity;
    }
    
    await saveSalesData();
  }

  /// Update sales from cart items
  Future<void> updateSalesFromCart(List<Map<String, dynamic>> cartItems) async {
    for (var item in cartItems) {
      final productName = item['productName'] as String;
      final quantity = item['quantity'] as int;
      
      final key = _getProductKey(productName);
      
      if (salesData.containsKey(key)) {
        salesData[key] = (salesData[key] ?? 0) + quantity;
      } else {
        salesData[key] = quantity;
      }
    }
    
    await saveSalesData();
  }

  /// Extract key from product name (first 2-3 words)
  String _getProductKey(String productName) {
    final words = productName.split(' ');
    if (words.length <= 2) return productName;
    return words.take(2).join(' ');
  }

  /// Get sales data for chart display
  List<MapEntry<String, int>> get chartData {
    // Return top 6 products by sales
    final entries = salesData.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(6).toList();
  }

  /// Clear all sales data
  Future<void> clearSalesData() async {
    salesData.clear();
    _initializeDummyData();
    await saveSalesData();
  }
}
