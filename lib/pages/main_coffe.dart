import 'package:coffe_concept/pages/coffee_home.dart';
import 'package:coffe_concept/pages/coffee_list.dart';
import 'package:flutter/material.dart';

class MainCoffee extends StatelessWidget {
  const MainCoffee({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: HomeCoffeeConcept(),
    );
  }
}