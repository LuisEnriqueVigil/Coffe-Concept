import 'package:coffe_concept/coffee.dart';
import 'package:flutter/material.dart';

class DetailCoffeeConcept extends StatelessWidget {
  final Coffee coffee; 
  const DetailCoffeeConcept({Key key, this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color:Colors.black
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal:size.width*0.2),
            child: Hero(
              tag: 'text_${coffee.name}',
              child: Material(
                child: Text(
                  coffee.name,
                  textAlign: TextAlign.center,
                  maxLines :2, 
                  style: TextStyle(
                    backgroundColor: Colors.transparent,
                    fontSize:22, 
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ), 
          SizedBox(height: 30.0),
          SizedBox(
            height: size.height*0.4,
            child: Stack(
              children: <Widget>[

                Positioned.fill(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(coffee.image,fit:BoxFit.fitHeight))
                ), 

                Positioned(
                  left: size.width*0.05,
                  bottom: 0,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin:1.0,end:0.0), 
                    duration: const Duration(milliseconds: 100), 
                    builder: (context,value,child){ 
                      return Transform.translate(
                        offset: Offset(-100*value, 240*value),
                        child: child); 
                    },
                    child: Text( 
                      '\$${coffee.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [ 
                          BoxShadow(
                            color:Colors.black, 
                            blurRadius: 10,
                            spreadRadius: 20.0
                          )
                        ]
                      ),
                    ),
                  )
                )
              
              ],
            ),
          )
        ],
      ),
    );
  }
}