import 'package:coffe_concept/coffee.dart';
import 'package:coffe_concept/pages/coffee_list.dart';
import 'package:flutter/material.dart';

class HomeCoffeeConcept extends StatelessWidget {
  const HomeCoffeeConcept({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (detail){ 
          if(detail.primaryDelta< -5){ 
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context,animation,_){
                  return FadeTransition(
                    opacity: animation, 
                    child: CoffeConcepList(),
                  );
                }
              )
            );
          }
        },
        child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child:DecoratedBox(
                  decoration: BoxDecoration(
                    gradient:LinearGradient(
                      begin: Alignment.topCenter, 
                      end: AlignmentDirectional.bottomCenter, 
                      colors: [ 
                        Color(0xffA89276),
                        Colors.white
                      ]
                    )
                  )
                )
              ), 
              Positioned(
                height: size.height*0.4,
                top: size.height*0.15,
                left: 0,
                right: 0,
                child: Hero(
                  tag:  coffees[6].name, 
                  child: Image.asset(coffees[6].image),
                )
              ),
              Positioned(
                height: size.height*0.7,
                bottom: 0,
                left: 0,
                right: 0,
                child: Hero(
                  tag: coffees[7].name, 
                  child: Image.asset(
                    coffees[7].image,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Positioned(
                height: size.height,
                bottom: -size.height*0.8,
                left: 0,
                right: 0,
                child: Hero(
                  tag:  coffees[8].name, 
                  child: Image.asset(
                    coffees[8].image,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Positioned(
                height: 140,
                bottom: size.height*0.25,
                left: 0,
                right: 0,
                child: Image.asset('assets/icon/logo.png'))
            ],
        ),
      )
    );
  }
}