import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherModel? weather;
  Future _fetchweatherData() async {
    final response = await ApiService.getWeatherApi("karachi");
    setState(() {
      weather = response;
    });
  }

  String toCelcius(double temp) {
    return ((temp - 31) * 5 / 9).toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _fetchweatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(weather?.name ?? "no data"),
                Text(weather?.clouds?.all.toString() ?? "no data"),
                Text(toCelcius(weather?.main?.feelsLike ?? 0) ?? "no data"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
