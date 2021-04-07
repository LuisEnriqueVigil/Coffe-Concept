import 'package:coffe_concept/coffee.dart';
import 'package:coffe_concept/pages/coffee_details.dart';
import 'package:flutter/material.dart';

const _initialPage = 7.0;

class CoffeConcepList extends StatefulWidget {

  const CoffeConcepList({Key key}) : super(key: key);

  @override
  _CoffeConcepListState createState() => _CoffeConcepListState();
}

class _CoffeConcepListState extends State<CoffeConcepList> {

  final _pageCoffeeController = PageController(
    viewportFraction: 0.35, // se mostrara 3 elementos
    initialPage: _initialPage.toInt(),
  );

  final _pageTextController = PageController(
    initialPage: _initialPage.toInt(),
  );

  double _currentPage = _initialPage; 
  Duration  _duration = Duration(milliseconds: 200);
  double _textPage = _initialPage; 
  //voy a escuchar el controller 
  void _coffeeScrollListener(){ 
      setState(() {
        _currentPage = _pageCoffeeController.page;
      });
  }

  void _coffeeTextScrollListener (){ 
      _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_coffeeTextScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_coffeeTextScrollListener);
    _pageTextController.dispose();
    _pageCoffeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 20,
              right: 20,
              bottom: -size.height*0.225,
              height: size.height*0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  boxShadow: [ 
                    BoxShadow(
                      color: Colors.brown,
                      blurRadius: 90, 
                      spreadRadius: 45
                    ),
                  ]
                )
              )
            ),
             
            Transform.scale(
              scale: 1.2,
              alignment: Alignment.bottomCenter,

              child: PageView.builder(

                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length +1 ,//TODO: revisar aqui
                onPageChanged: (value){ 
                  if(value<coffees.length){
                    _pageTextController.animateToPage(
                      value, 
                      duration: Duration(milliseconds: 500), 
                      curve: Curves.easeOut
                    );
                  }
                },
                
                itemBuilder: (context,index){

                  if(index ==0){ 
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index-1]; 
                  final result = _currentPage - index;
                  final valores = -0.6 * result +1; 
                  final opacity = valores.clamp(0.0, 1.0);
             
                  return GestureDetector(

                    onTap: (){
                      Navigator.of(context).push( 
                        PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (context,animation,_){ 
                          return FadeTransition(
                            opacity: animation, 
                            child: DetailCoffeeConcept(
                              coffee: coffee,
                            ),
                          ); 
                        }
                      )
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom:40.0),
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..setEntry(3, 2 , 0.001)
                        ..translate(
                          0.0, 
                          size.height/5 * (1.4-valores).abs())
                        ..scale(valores),
                        child: Opacity(
                          opacity: opacity,
                          child: Hero(
                            tag: coffee.name,
                            child: Image.asset(
                              coffee.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ))),
                    ),
                  );
                }
              ),
            ),
            Positioned(
               top: 0,
               left: 0,
               right: 0,
               height: 120,
               child: Column(
                 children: <Widget>[

                   Expanded(
                     child: PageView.builder(
                       itemCount: coffees.length,
                       controller: _pageTextController,
                       physics:  const NeverScrollableScrollPhysics(),
                       itemBuilder: (context,index) {
                       final opacity = (1-(index- _textPage).abs()).clamp(0.0, 1.0);
                       return Opacity(
                         opacity: opacity,
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal:size.width*0.2),
                           child: Hero(
                             tag: "text_${coffees[index].name}",
                             child: Material(
                               child: Text(coffees[index].name,
                               maxLines: 2,
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 32.0,
                                 fontWeight: FontWeight.w700
                                 ),
                               ),
                             ),
                           ),
                         )
                        ); 
                     })
                   ),

                  // SizedBox(height: 20.0),

                   AnimatedSwitcher(
                     duration:_duration,
                     child: Text(
                       '\$${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}', 
                       style: TextStyle(
                         fontSize: 22.0
                       ),
                      ),
                       key: Key(coffees[_currentPage.toInt()].name),
                   )
                 ],
               )
             ), 
          ],
        ),
    );
  }
}