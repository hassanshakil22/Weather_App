import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/bigcard_view.dart';
// import 'package:intl/intl.dart';
// import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/card_view.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/utils/colors.dart';
// import 'package:weatherapp/service/api_service.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:weatherapp/utils/colors.dart';

class HomeView extends StatefulWidget {
  final String cityname;

  const HomeView({super.key, required this.cityname});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherModel? weather;
  bool? isDaytime;

  Future _fetchweatherData() async {
    final response = await ApiService.getWeatherApi(widget.cityname);
    setState(() {
      weather = response;
    });
  }

  bool isDay({required int? dt, required int? sunrise, required int? sunset}) {
    if (dt != null && sunrise != null && sunset != null) {
      return isDaytime = dt >= sunrise && dt < sunset;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDay(
                dt: weather?.dt,
                sunrise: weather?.sys?.sunrise,
                sunset: weather?.sys?.sunset)
            ? AppColors.appBackgroundDay
            : AppColors.appBackgroundNight,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: [
                CardView(
                  cityname: widget.cityname,
                ),
                BigcardView(cityname: widget.cityname),
              ],
            ),
          ),
        ));
  }
}
