
import 'dart:math'; 

double _doubleInRange (Random source, num start , num end) => source.nextDouble() * (end - start) +start; 

final random =  Random(); 

final coffees = List.generate(
  _names.length, (index) => Coffee(
    name: _names[index],
    image: 'assets/coffee/${index +1}.png',
    price: _doubleInRange(random, 3, 7),
  )
);

class Coffee { 

  final String name; 
  final String image; 
  final double price; 

  Coffee({
    this.name,
    this.price,
    this.image
  });
}

  final _names = [ 
    'Caramel Cold Drink', 
    'Iced Coffee Mocha', 
    'Tofee Nut Latte', 
    'Capuchino', 
    'Cafe Pasado', 
    'Americano', 
    'Black Tea Latte', 
    'Classic Irish Coffe', 
    'Toffe nut Cruchn Latte', 
    'Caramel Macchiato', 
    'Cafe Puro', 
    'Malteado',
  ];



  