import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Card extends StatefulWidget {
  const Card({super.key});

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center() ,
    );
  }
}