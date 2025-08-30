mixin Flying {
  void fly() => print('I\'m flying!');
}

mixin Swimming {
  void swim() => print('I\'m swimming!');
}

class Duck with Flying, Swimming {}

class Airplane with Flying {}

void main(){
var duck = Duck();
duck.fly();  // I'm flying!
duck.swim(); // I'm swimming!

var airplane = Airplane();
airplane.fly(); // I'm flying!
}