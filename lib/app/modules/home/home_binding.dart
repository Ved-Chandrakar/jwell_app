import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/sales_controller.dart';
import '../../controllers/cart_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<SalesController>(() => SalesController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
