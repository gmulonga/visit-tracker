import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/controllers/customer_controller.dart';
import 'package:visit_tracker/app/data/models/customer_model.dart';
import 'package:visit_tracker/app/utils/utils.dart';

import '../../app/controllers/activity_controller.dart';
import '../../app/data/models/activity_model.dart';
import '../../app/data/models/visit_model.dart';
import '../data/services/api_constants.dart';

class VisitDetailPage extends StatelessWidget {
  final Visit visit;
  final ActivityController activityController = Get.find();
  final CustomerController customerController = Get.find();

  VisitDetailPage({required this.visit});

  @override
  Widget build(BuildContext context) {
    final customer = customerController.customers.firstWhere(
      (c) => c.id == visit.customerId,
      orElse:
          () => Customer(
            id: 0,
            name: 'Unknown Customer',
            createdAt: DateTime.now(),
          ),
    );

    List<Activity> matchedActivities =
        activityController.activities
            .where(
              (activity) =>
                  visit.activitiesDone.contains(activity.id.toString()),
            )
            .toList();

    return Scaffold(
      backgroundColor: kGrey,
      appBar: AppBar(
        title: Text('Visit Details', style: TextStyle(color: kWhite)),
        backgroundColor: kGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (activityController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: kGreen),
                    const SizedBox(width: 6),
                    Text(
                      formatDate(visit.visitDate),
                      style: TextStyle(fontSize: kNormalFont),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: kGreen),
                    const SizedBox(width: 6),
                    Text(visit.status, style: TextStyle(fontSize: kNormalFont)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 18, color: kGreen),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        visit.location,
                        style: TextStyle(fontSize: kNormalFont),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.note_alt_outlined, size: 18, color: kGreen),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        visit.notes.isNotEmpty
                            ? visit.notes
                            : 'No notes available',
                        style: TextStyle(
                          fontSize: kNormalFont,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Activities Done:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kGreen,
                  ),
                ),
                const SizedBox(height: 8),
                ...matchedActivities.map(
                  (a) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: kGreen,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            a.description,
                            style: TextStyle(fontSize: kNormalFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
