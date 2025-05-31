import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visit_tracker/app/controllers/customer_controller.dart';
import 'package:visit_tracker/widgets/custom_button.dart';
import 'package:visit_tracker/widgets/custom_input.dart';

import '../../widgets/custom_dropdown.dart';
import '../controllers/activity_controller.dart';
import '../controllers/visit_controller.dart';
import '../data/models/visit_model.dart';
import '../data/services/api_constants.dart';

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
      formattedDateController.text = DateFormat(
        'MMMM dd, yyyy – h:mm a',
      ).format(combined);
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
      appBar: AppBar(
        title: Text('Add Visit', style: TextStyle(color: kWhite)),
        backgroundColor: kGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (activityController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Text(
                'Select Customer',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Obx(() {
                if (customerController.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<int>(
                      value:
                          customerIdController.text.isEmpty
                              ? null
                              : int.tryParse(customerIdController.text),
                      items: [
                        DropdownMenuItem<int>(
                          value: null,
                          enabled: false,
                          child: Text(
                            'Please select',
                            style: TextStyle(color: kGreen),
                          ),
                        ),
                        ...customerController.customers.map((customer) {
                          return DropdownMenuItem<int>(
                            value: customer.id,
                            child: Text('${customer.name} (${customer.id})'),
                          );
                        }).toList(),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          customerIdController.text = value?.toString() ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        hintText: 'Please select',
                        hintStyle: TextStyle(color: kGreen),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: kGreen, width: 1.0),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }),
              GestureDetector(
                onTap: () => pickDateTime(context),
                child: AbsorbPointer(
                  child: InputField(
                    hintText: "01/01/2025",
                    label: "Visit Date & Time",
                    controller: formattedDateController,
                  ),
                ),
              ),
              CustomDropdown(
                label: 'Status',
                value: selectedStatus,
                items: ['Select Status', ...statusOptions],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                    statusController.text = newValue ?? '';
                  });
                },
                isRequired: true,
              ),
              InputField(
                hintText: "Nairobi",
                label: "Location",
                controller: locationController,
              ),
              InputField(
                hintText: "Type your notes here",
                label: 'Notes',
                controller: notesController,
                maxLines: 4,
              ),
              SizedBox(height: 20),
              Text(
                'Select Activities',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: kNormalFont,
                ),
              ),
              Wrap(
                spacing: 10,
                children:
                    activityController.activities.map((activity) {
                      final isSelected = selectedActivityIds.contains(
                        activity.id.toString(),
                      );
                      return FilterChip(
                        label: Text(
                          activity.description,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedActivityIds.add(activity.id.toString());
                            } else {
                              selectedActivityIds.remove(
                                activity.id.toString(),
                              );
                            }
                          });
                        },
                        selectedColor: kGreen,
                        checkmarkColor: kWhite,
                      );
                    }).toList(),
              ),
              SizedBox(height: 10),
              CustomButton(callBackFunction: submitVisit, label: "Add Visit"),
            ],
          );
        }),
      ),
    );
  }
}
