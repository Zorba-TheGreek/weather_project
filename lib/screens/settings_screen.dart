import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/weather_view_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  List<String> countries = [];
  List<String> cities = [];
  String? selectedCountry;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    final response = await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> countryList = data['data'];
      List<String> countryNames = countryList.map((country) => country['country'] as String).toList();
      setState(() {
        countries = countryNames;
        selectedCountry = countries.isNotEmpty ? countries[0] : null;
        _fetchCities(selectedCountry!);
      });
    }
  }

  Future<void> _fetchCities(String country) async {
    final response = await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries/cities'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'][country] != null) {
        setState(() {
          cities = List<String>.from(data['data'][country]);
          selectedCity = cities.isNotEmpty ? cities[0] : null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select country:'),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  cities.clear();
                  _fetchCities(value!);
                });
              },
              items: countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 16),
            Text('Select city:'),
            DropdownButtonFormField<String>(
              value: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherByCity(
                  selectedCity!,
                  selectedCountry!,
                );
                Navigator.pop(context); // Close settings screen
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
