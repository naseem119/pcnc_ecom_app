import 'package:get/get.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/ecommerce_repository.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var fetchedCategories = await EcommerceRepository.getCategories();
      if (fetchedCategories != null) {
        categories.value = fetchedCategories;
      }
    } finally {
      isLoading(false);
    }
  }
}
