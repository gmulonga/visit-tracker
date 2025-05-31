import 'package:flutter_test/flutter_test.dart';
import 'package:visit_tracker/app/data/models/activity_model.dart';

void main() {
  group('Activity model', () {
    test('fromJson should parse JSON into an Activity object', () {
      final json = {
        'id': 10,
        'description': 'Sample activity',
        'created_at': '2024-05-30T15:45:00.000Z',
      };

      final activity = Activity.fromJson(json);

      expect(activity.id, 10);
      expect(activity.description, 'Sample activity');
      expect(activity.createdAt, DateTime.parse('2024-05-30T15:45:00.000Z'));
    });
  });
}
