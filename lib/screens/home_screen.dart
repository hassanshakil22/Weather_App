import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:weatherapp/utils/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherModel? weather;
  String? formattedDay;
  DateTime? dateTime;

  Future _fetchweatherData() async {
    final response = await ApiService.getWeatherApi("karachi");
    setState(() {
      weather = response;
      dateTime = DateTime.fromMillisecondsSinceEpoch(weather!.dt! * 1000);
    });
  }

  giveDay(int timeSinceepoch) {
    if (dateTime != null) {
      formattedDay = DateFormat('EEEE').format(dateTime!);
      return formattedDay;
    } else {
      return "Unknown";
    }
  }

  String toCelcius(double temp) {
    return "${(temp - 273).toStringAsFixed(0).toString()}°C ";
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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.4,
                      fit: BoxFit.cover,
                      image: Svg(
                        'assets/images/night.svg',
                      ))),
              height: 300,
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      giveDay(weather?.dt ?? 0),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.fontColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${dateTime?.day} ${DateFormat('MMMM').format(dateTime!)} ${dateTime?.year} ",
                        style: TextStyle(
                            color: AppColors.fontColor,
                            fontWeight: FontWeight.w300),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.fontColor,
                        ),
                        Text(
                          weather?.name ?? " no data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.fontColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  weather?.weather?[0].main == "Clear"
                      ? Icon(Icons.sunny)
                      : weather?.weather?[0].main == "cloudy"
                          ? Icon(Icons.cloud)
                          : Text(weather?.weather?[0].main ?? ""),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
