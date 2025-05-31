import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visit_tracker/app/controllers/customer_controller.dart';

import '../../widgets/custom_text_field.dart';
import '../controllers/visit_controller.dart';
import '../controllers/activity_controller.dart';
import '../data/models/visit_model.dart';

class AddVisitPage extends StatefulWidget {
  @override
  _AddVisitPageState createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  final VisitController visitController = Get.find();
  final ActivityController activityController = Get.put(ActivityController());
  final CustomerController customerController = Get.put(CustomerController());

  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController formattedDateController = TextEditingController();

  final List<String> statusOptions = ['Completed', 'Pending', 'Cancelled'];
  String? selectedStatus;

  DateTime? selectedDateTime;
  List<String> selectedActivityIds = [];

  @override
  void initState() {
    super.initState();
    activityController.fetchActivities();
    customerController.fetchCustomers();
  }

  Future<void> pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final DateTime combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = combined;
      formattedDateController.text = DateFormat('MMMM dd, yyyy – h:mm a').format(combined);
      dateController.text = combined.toUtc().toIso8601String();
    });
  }


  void submitVisit() {
    final newVisit = Visit(
      customerId: int.tryParse(customerIdController.text) ?? 0,
      visitDate: dateController.text,
      status: statusController.text,
      location: locationController.text,
      notes: notesController.text,
      activitiesDone: selectedActivityIds,
    );

    visitController.addVisit(newVisit);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Visit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (activityController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Text('Select Customer', style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() {
                if (customerController.isLoading.value) {
                  return CircularProgressIndicator();
                }

                return DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: customerIdController.text.isEmpty ? null : int.tryParse(customerIdController.text),
                  hint: Text('Please select'),
                  items: customerController.customers.map((customer) {
                    return DropdownMenuItem<int>(
                      value: customer.id,
                      child: Text('${customer.name} (${customer.id})'),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      customerIdController.text = value?.toString() ?? '';
                    });
                  },
                );

              }),
              GestureDetector(
                onTap: () => pickDateTime(context),
                child: AbsorbPointer(
                  child: CustomTextField(label: 'Visit Date & Time', controller: formattedDateController),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                hint: Text('Please select'),
                value: selectedStatus,
                items: statusOptions.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                    statusController.text = newValue ?? '';
                  });
                },
              ),
              CustomTextField(label: 'Location', controller: locationController),
              CustomTextField(label: 'Notes', controller: notesController),

              SizedBox(height: 20),
              Text('Select Activities', style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: activityController.activities.map((activity) {
                  final isSelected = selectedActivityIds.contains(activity.id.toString());
                  return FilterChip(
                    label: Text(activity.description),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedActivityIds.add(activity.id.toString());
                        } else {
                          selectedActivityIds.remove(activity.id.toString());
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: submitVisit,
                child: Text('Submit'),
              )
            ],
          );
        }),
      ),
    );
  }
}
