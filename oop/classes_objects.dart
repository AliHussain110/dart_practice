class Person {
  // Properties (fields)
  String name;
  int age;
  
  // Constructor
  Person(this.name, this.age);
  
  // Method
  void introduce() {
    print('Hi, I\'m $name and I\'m $age years old.');
  }
}

void main(){
  // Creating objects
Person alice = Person('Ali', 23);
Person bob = Person('Hussain', 2);

alice.introduce(); // Hi, I'm Ali and I'm 23 years old.
bob.introduce();   // Hi, I'm Hussain and I'm 2 years old.
}