// The Animal class now acts as the 'interface' or 'contract'.
class Animal {
  String name =
      ''; // We must explicitly declare the property within the interface

  // We define the signature that implementing classes must follow
  void makeSound() {}
  void wagTail() {}
}

// The Dog class implements the Animal contract.
// We must now define every single member (name, makeSound, wagTail) ourselves.
class Dog implements Animal {
  // We MUST declare the 'name' property ourselves,
  // we don't inherit the one from 'Animal'
  @override
  String name;

  // We can add our own constructor specific to our implementation
  Dog(this.name);

  // We MUST provide an implementation for ALL methods in the contract
  @override
  void makeSound() {
    print('Bark!');
  }

  @override
  void wagTail() {
    print('Tail wagging');
  }
}

void main() {
  var dog = Dog('Rex');
  dog.makeSound(); // Bark!
  dog.wagTail(); // Tail wagging
  print(dog.name); // Rex
}
