import 'package:get/get.dart';
import '../data/models/customer_model.dart';
import '../data/services/api_service.dart';

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  void fetchCustomers() async {
    try {
      isLoading.value = true;
      final data = await ApiService.fetchCustomers();
      customers.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
