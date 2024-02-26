import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/weather_view_model.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<WeatherViewModel>(
              builder: (context, model, child) {
                if (model.loading) {
                  return CircularProgressIndicator();
                } else if (model.error.isNotEmpty) {
                  return Text(model.error);
                } else if (model.weatherList.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: model.weatherList.length,
                    itemBuilder: (context, index) {
                      var weather = model.weatherList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weather.temperature.toString()}°C',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 8),
                              Text(
                                weather.condition,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${weather.location}, ${weather.country}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No weather data available');
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await _checkLocationPermission()) {
            Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherByLocation();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Location permission is required.'),
            ));
          }
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<bool> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }
}
