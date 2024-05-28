import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:weatherapp/utils/colors.dart';

class CardView extends StatefulWidget {
  final String cityname;
  const CardView({super.key, required this.cityname});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  WeatherModel? weather;
  String? formattedDay;
  DateTime? dateTime;
  bool? isDaytime;
  Future _fetchweatherData() async {
    final response = await ApiService.getWeatherApi(widget.cityname);
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

  String toCelcius(double? temp) {
    if (temp != null) {
      return "${(temp - 273).toStringAsFixed(0).toString()}°C ";
    } else {
      return "--°C";
    }
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
    return weather == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  alignment: const Alignment(-0.8, 0),
                  image: isDay(
                          dt: weather?.dt,
                          sunrise: weather?.sys?.sunrise,
                          sunset: weather?.sys?.sunset)
                      ? const Svg(
                          'assets/images/day.svg',
                        )
                      : const Svg(
                          'assets/images/night.svg',
                        ),
                  // colorFilter: ColorFilter.mode(
                  //   Colors.grey.withOpacity(
                  //       0.5), // Adjust the color and opacity to make the image duller
                  //   BlendMode.darken,
                  // ),
                )),
            height: 300,
            width: 200,
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
                        color: AppColors.cardfontColor),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      dateTime != null
                          ? "${dateTime!.day} ${DateFormat('MMMM').format(dateTime!)} ${dateTime!.year}"
                          : "Loading...", // Provide a fallback value when dateTime is null,
                      style: TextStyle(
                          color: AppColors.cardfontColor,
                          fontWeight: FontWeight.w300),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.cardfontColor,
                      ),
                      Row(
                        children: [
                          Text(
                            '${weather?.name} ,',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardfontColor),
                          ),
                          Text(
                            weather?.sys?.country ?? "no data",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardfontColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ignore: prefer_const_constructors
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 40),
                  child: Column(
                    children: [
                      weather?.weather?[0].main == "Clear"
                          ? Icon(Icons.sunny,
                              size: 40, color: AppColors.cardfontColor)
                          : weather?.weather?[0].main == "Clouds"
                              ? Icon(
                                  Icons.cloud,
                                  size: 40,
                                  color: AppColors.cardfontColor,
                                )
                              : weather?.weather?[0].main == "Haze"
                                  ? Icon(Icons.water,
                                      size: 40, color: AppColors.cardfontColor)
                                  : weather?.weather?[0].main == "Dust"
                                      ? Icon(Icons.air,
                                          size: 40,
                                          color: AppColors.cardfontColor)
                                      : weather?.weather?[0].main == "Rain"
                                          ? Icon(Icons.thunderstorm_outlined,
                                              size: 40,
                                              color: AppColors.cardfontColor)
                                          : Icon(Icons.remove,
                                              size: 40,
                                              color: AppColors.cardfontColor),
                      Text(
                        toCelcius(weather?.main?.temp),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.cardfontColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          weather?.weather?[0].description ?? "no data",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.cardfontColor,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
