import 'package:get/get.dart';
import '../controllers/visit_controller.dart';
import '../controllers/customer_controller.dart';
import '../controllers/activity_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(VisitController());
    Get.put(CustomerController());
    Get.put(ActivityController());
  }
}
