import 'package:flutter_test/flutter_test.dart';
import 'package:visit_tracker/app/data/models/customer_model.dart';

void main() {
  group('Customer model', () {
    test('fromJson should parse JSON into a Customer object', () {
      final json = {
        'id': 5,
        'name': 'Alice Johnson',
        'created_at': '2024-05-01T10:30:00.000Z',
      };

      final customer = Customer.fromJson(json);

      expect(customer.id, 5);
      expect(customer.name, 'Alice Johnson');
      expect(customer.createdAt, DateTime.parse('2024-05-01T10:30:00.000Z'));
    });
  });
}
