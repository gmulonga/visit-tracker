import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/add_visit_page.dart';
import '../pages/stats_page.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/add-visit', page: () => AddVisitPage()),
    GetPage(name: '/stats', page: () => StatsPage()),
  ];
}
