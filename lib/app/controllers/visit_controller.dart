import 'package:get/get.dart';

import '../data/models/visit_model.dart';
import '../data/services/api_service.dart';

class VisitController extends GetxController {
  var visits = <Visit>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchVisits();
    super.onInit();
  }

  void fetchVisits() async {
    try {
      isLoading.value = true;
      final data = await ApiService.fetchVisits();
      visits.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addVisit(Visit visit) async {
    try {
      await ApiService.addVisit(visit);
      Get.snackbar('Success', 'You have added a visit');
      fetchVisits();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add visit');
    }
  }
}
