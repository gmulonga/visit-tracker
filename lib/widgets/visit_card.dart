import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/data/services/api_constants.dart';
import 'package:visit_tracker/app/utils/utils.dart';

import '../../app/controllers/customer_controller.dart';
import '../../app/data/models/visit_model.dart';
import '../../app/pages/visit_detail_page.dart';
import '../app/data/models/customer_model.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;
  final CustomerController customerController = Get.find();

  VisitCard({required this.visit});

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

    final customerName = customer != null ? customer.name : 'Unknown Customer';

    return Card(
      color: kWhite,
      child: ListTile(
        title: Text(
          '$customerName',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kGreen,
            fontSize: kNormalFont,
          ),
        ),
        subtitle: Text(
          'Status: ${visit.status}\nDate: ${formatDate(visit.visitDate)}',
          style: TextStyle(fontSize: kNormalFont),
        ),
        onTap: () => Get.to(() => VisitDetailPage(visit: visit)),
      ),
    );
  }
}
