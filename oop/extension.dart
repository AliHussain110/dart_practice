class Person{
  String name;
  Person(this.name);
}

extension Greetings on Person{
  String get greet => 'Hello ${this.name}!';
}

void main(){
  var person = Person('Ali Hussain');
  print(person.greet);
}