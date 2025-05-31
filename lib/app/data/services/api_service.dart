import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/visit_model.dart';
import '../models/customer_model.dart';
import '../models/activity_model.dart';
import 'api_constants.dart';

class ApiService {
  static Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/customers'), headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Customer.fromJson(e)).toList();
    }
    throw Exception('Failed to load customers');
  }

  static Future<List<Activity>> fetchActivities() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/activities'), headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Activity.fromJson(e)).toList();
    }
    throw Exception('Failed to load activities');
  }

  static Future<List<Visit>> fetchVisits() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/visits'), headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Visit.fromJson(e)).toList();
    }
    throw Exception('Failed to load visits');
  }

  static Future<void> addVisit(Visit visit) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/visits'),
      headers: ApiConstants.headers,
      body: json.encode(visit.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add visit');
    }
  }
}
