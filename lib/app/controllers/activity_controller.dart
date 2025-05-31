import 'package:get/get.dart';
import '../data/models/activity_model.dart';
import '../data/services/api_service.dart';

class ActivityController extends GetxController {
  var activities = <Activity>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchActivities();
    super.onInit();
  }

  void fetchActivities() async {
    try {
      isLoading.value = true;
      final data = await ApiService.fetchActivities();
      activities.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
