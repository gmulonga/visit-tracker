import 'package:flutter/material.dart';
import 'package:visit_tracker/app/utils/utils.dart';
import '../../app/data/models/visit_model.dart';
import 'package:get/get.dart';
import '../../app/pages/visit_detail_page.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;
  VisitCard({required this.visit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Visit to Customer ID: ${visit.customerId}'),
        subtitle: Text('Status: ${visit.status}\nDate: ${formatDate(visit.visitDate)}'),
        onTap: () => Get.to(() => VisitDetailPage(visit: visit)),
      ),
    );
  }
}