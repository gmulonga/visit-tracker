import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/visit_controller.dart';

class StatsPage extends StatelessWidget {
  final VisitController visitController = Get.find();

  @override
  Widget build(BuildContext context) {
    final completed = visitController.visits.where((v) => v.status == 'Completed').length;
    final pending = visitController.visits.where((v) => v.status == 'Pending').length;
    final cancelled = visitController.visits.where((v) => v.status == 'Cancelled').length;

    return Scaffold(
      appBar: AppBar(title: Text('Visit Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Completed: $completed'),
            Text('Pending: $pending'),
            Text('Cancelled: $cancelled'),
          ],
        ),
      ),
    );
  }
}