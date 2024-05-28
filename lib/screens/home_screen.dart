import 'package:flutter/material.dart';
import 'package:weatherapp/screens/bigcard_view.dart';
// import 'package:intl/intl.dart';
// import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/card_view.dart';
// import 'package:weatherapp/service/api_service.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:weatherapp/utils/colors.dart';

class HomeView extends StatelessWidget {
  final String cityname;

  const HomeView({super.key, required this.cityname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Row(
            children: [
              CardView(
                cityname: cityname,
              ),
              BigcardView(cityname: cityname),
            ],
          ),
        ));
  }
}

TextEditingController _controller = TextEditingController();
