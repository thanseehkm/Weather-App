import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherData extends ChangeNotifier {
  static var dayinfo = DateTime.now();
  var formatedDate = DateFormat('EEE, d MMM, yyyy').format(dayinfo);
  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<Weather> getWeatherData(String? data) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      var location = '${position.latitude},${position.longitude}';
      _isLoading = true;
      _errorMessage = ''; // Reset error message
      notifyListeners();

      var uriCall = Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=a8bc91c860a64b7691f83133233105&q=${data},$location&aqi=no');

      var response = await http.get(uriCall);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return Weather.fromJson(body);
      } else {
        _errorMessage = 'Failed to load weather data: ${response.statusCode}';

        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _errorMessage = 'Failed to load weather data. Please try again later.';

      throw Exception('Failed to load weather data. Please try again later.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
