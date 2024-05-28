import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/service/api_service.dart';

class DirectingView extends StatefulWidget {
  const DirectingView({super.key});

  @override
  State<DirectingView> createState() => _DirectingViewState();
}

TextEditingController _controller = TextEditingController();

class _DirectingViewState extends State<DirectingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Enter City"),
                    content: TextField(
                      controller: _controller,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              await ApiService.getWeatherApi(_controller.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(
                                      cityname: _controller.text,
                                    ),
                                  ));
                            } catch (e) {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text(
                                            "Error",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: Text(e.toString()),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close the dialog
                                              },
                                              child: const Text("OK"),
                                            )
                                          ]));
                            }
                          },
                          child: const Text("Submit"))
                    ],
                  ),
                );
                print(_controller.text);
              },
              child: const Text("Enter Your City"))),
    );
  }
}
