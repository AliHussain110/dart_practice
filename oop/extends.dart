class Animal {
  String name;
  
  Animal(this.name);
  
  void makeSound() {
    print('Some generic sound');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);
  
  @override
  void makeSound() {
    print('Bark!');
  }
  
  void wagTail() {
    print('Tail wagging');
  }
}

void main(){
var dog = Dog('Rex');
dog.makeSound(); // Bark!
dog.wagTail();   // Tail wagging
}