import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Fetch jewellery products from API
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final fetchedProducts = await _apiService.fetchJewelleryProducts();
      products.value = fetchedProducts;
      
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Retry fetching products
  void retry() {
    fetchProducts();
  }

  /// Get featured products (first 2-3 for horizontal list)
  List<Product> get featuredProducts {
    return products.take(3).toList();
  }
}
