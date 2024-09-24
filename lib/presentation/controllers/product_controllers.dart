import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/ecommerce_repository.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var fetchedProducts = await EcommerceRepository.getProducts();
      if (fetchedProducts != null) {
        products.value = fetchedProducts;
      }
    } finally {
      isLoading(false);
    }
  }
}
