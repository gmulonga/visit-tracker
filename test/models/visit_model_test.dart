import 'package:flutter_test/flutter_test.dart';
import 'package:visit_tracker/app/data/models/visit_model.dart';

void main() {
  group('Visit model', () {
    test('fromJson should create Visit instance correctly', () {
      final json = {
        'customer_id': 1,
        'visit_date': '2024-05-01',
        'status': 'completed',
        'location': 'Nairobi',
        'notes': 'Follow-up meeting',
        'activities_done': ['Activity A', 'Activity B'],
      };

      final visit = Visit.fromJson(json);

      expect(visit.customerId, 1);
      expect(visit.visitDate, '2024-05-01');
      expect(visit.status, 'completed');
      expect(visit.location, 'Nairobi');
      expect(visit.notes, 'Follow-up meeting');
      expect(visit.activitiesDone, ['Activity A', 'Activity B']);
    });

    test('toJson should return correct map', () {
      final visit = Visit(
        customerId: 2,
        visitDate: '2024-06-01',
        status: 'pending',
        location: 'Kampala',
        notes: 'Initial consultation',
        activitiesDone: ['Intro', 'Survey'],
      );

      final json = visit.toJson();

      expect(json['customer_id'], 2);
      expect(json['visit_date'], '2024-06-01');
      expect(json['status'], 'pending');
      expect(json['location'], 'Kampala');
      expect(json['notes'], 'Initial consultation');
      expect(json['activities_done'], ['Intro', 'Survey']);
    });
  });
}
