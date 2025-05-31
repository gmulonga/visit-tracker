import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1';
  static const String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c';
  static const headers = {
    'apikey': apiKey,
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };
}

const kGreen = Color(0xFF129990);
const kWhite = Color(0xFFFFFFFF);
const kLightGreen = Color(0xFFDDF6D2);
const kGrey = Color(0xFF7F8CAA);