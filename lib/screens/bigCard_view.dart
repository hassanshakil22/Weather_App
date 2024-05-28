import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/utils/colors.dart';

class BigcardView extends StatefulWidget {
  final String cityname;
  const BigcardView({super.key, required this.cityname});

  @override
  State<BigcardView> createState() => _BigcardViewState();
}

class _BigcardViewState extends State<BigcardView> {
  WeatherModel? weather;
  String? formattedDay;
  DateTime? dateTime;
  bool? isDaytime;
  TextEditingController _controller = TextEditingController();
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
            width: 200,
            height: 280,
            color: isDay(
                    dt: weather?.dt,
                    sunrise: weather?.sys?.sunrise,
                    sunset: weather?.sys?.sunset)
                ? AppColors.bigCardColorday
                : AppColors.bigCardColorNight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(children: [
                    Text(
                      "PERCIPITATION",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      '${(weather?.rain?.d1h == null ? 0 : weather!.rain!.d1h! * 100).toString()} %',
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //percipitation row
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Text(
                      "HUMIDITY",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      "${weather?.main?.humidity.toString() ?? "0"} %",
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //humidity row
                  const SizedBox(
                    height: 10,
                  ),

                  Row(children: [
                    Text(
                      "WIND",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      '${weather?.wind?.speed.toString() ?? 0} km/h',
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //wind row
                  const SizedBox(
                    height: 10,
                  ),

                  Row(children: [
                    Text(
                      "WIND DIRECTION",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      '${weather?.wind?.deg.toString() ?? 0}°',
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //wind row
                  const SizedBox(
                    height: 10,
                  ),

                  Row(children: [
                    Text(
                      "FEELS LIKE",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      toCelcius(weather?.main?.feelsLike),
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //wind row
                  const SizedBox(
                    height: 10,
                  ),

                  Row(children: [
                    Text(
                      "PRESSURE",
                      style: TextStyle(
                          color: AppColors.bigcardfontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      '${weather?.main?.pressure.toString() ?? 0} hPa',
                      style: TextStyle(color: AppColors.bigcardfontColor),
                    )
                  ]), //wind row
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Search Location"),
                          actions: [
                            TextField(
                              controller: _controller,
                            )
                          ],
                        ),
                      );
                    },
                    label: Text(
                      "Change Location",
                      style: TextStyle(color: AppColors.cardfontColor),
                    ),
                    icon: Icon(Icons.location_on_outlined,
                        color: AppColors.bigCardColorNight),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isDay(
                                dt: weather?.dt,
                                sunrise: weather?.sys?.sunrise,
                                sunset: weather?.sys?.sunset)
                            ? Colors.white60
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
            ),
          );
  }
}
