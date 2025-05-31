class Visit {
  final int customerId;
  final String visitDate;
  final String status;
  final String location;
  final String notes;
  final List<String> activitiesDone;

  Visit({
    required this.customerId,
    required this.visitDate,
    required this.status,
    required this.location,
    required this.notes,
    required this.activitiesDone,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      customerId: json['customer_id'],
      visitDate: json['visit_date'],
      status: json['status'],
      location: json['location'],
      notes: json['notes'],
      activitiesDone: json['activities_done'] != null
          ? List<String>.from(json['activities_done'].map((e) => e.toString()))
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'visit_date': visitDate,
      'status': status,
      'location': location,
      'notes': notes,
      'activities_done': activitiesDone,
    };
  }
}
