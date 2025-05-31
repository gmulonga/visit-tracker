import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/routes/app_routes.dart';

import '../../widgets/visit_card.dart';
import '../controllers/visit_controller.dart';
import '../data/services/api_constants.dart';

class HomePage extends StatelessWidget {
  final VisitController visitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      appBar: AppBar(
        title: Text('Visits Tracker', style: TextStyle(color: kWhite)),
        backgroundColor: kGreen,
      ),
      body: Obx(() {
        if (visitController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (visitController.visits.isEmpty) {
          return Center(child: Text('No visits available'));
        }
        return ListView.builder(
          itemCount: visitController.visits.length,
          itemBuilder: (context, index) {
            final visit = visitController.visits[index];
            return VisitCard(visit: visit);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen,
        onPressed: () => Get.toNamed(Routes.ADD_VISIT),
        child: Icon(Icons.add, color: kWhite),
        shape: CircleBorder(),
      ),
    );
  }
}
