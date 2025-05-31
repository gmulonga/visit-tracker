import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/utils/utils.dart';
import '../../app/data/models/visit_model.dart';
import '../../app/controllers/activity_controller.dart';
import '../../app/data/models/activity_model.dart';

class VisitDetailPage extends StatelessWidget {
  final Visit visit;
  final ActivityController activityController = Get.find();

  VisitDetailPage({required this.visit});

  @override
  Widget build(BuildContext context) {
    // Get activities by matching IDs
    List<Activity> matchedActivities = activityController.activities
        .where((activity) => visit.activitiesDone.contains(activity.id.toString()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Visit Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (activityController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer ID: ${visit.customerId}'),
              Text('Date: ${formatDate(visit.visitDate)}'),
              Text('Status: ${visit.status}'),
              Text('Location: ${visit.location}'),
              Text('Notes: ${visit.notes}'),
              SizedBox(height: 16),
              Text('Activities Done:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...matchedActivities.map((a) => Text('- ${a.description}')).toList(),
            ],
          );
        }),
      ),
    );
  }
}
