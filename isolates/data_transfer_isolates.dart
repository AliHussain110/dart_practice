// Challenge 3: Complex Data Transfer
// Create an isolate that processes a complex data structure

import 'dart:isolate';

class Person {
  final String name;
  final int age;
  
  Person(this.name, this.age);
}

// TODO: Implement this function
// 1. Create an isolate that receives a list of Person objects
// 2. Filter the list to only include people who are 18 or older
// 3. Sort the filtered list by name
// 4. Send the sorted list back to the main isolate
// 5. Return the sorted list from the function
Future<List<Person>> filterAndSortAdults(List<Person> people) async {
  // TODO: Implement this function to process complex data in an isolate
  final filterAndSortedAdults = await Isolate.run((){
   final filterPeople =  people.where((person)=> person.age >= 18).toList();
   filterPeople.sort((a,b)=> a.name.compareTo(b.name));
   return filterPeople;
  });
  return filterAndSortedAdults;
}

// Tests your solution (Don't edit!):
void main() async {
  final input = [
    Person('Charlie', 15),
    Person('Alice', 25),
    Person('Bob', 17),
    Person('David', 30),
    Person('Eve', 18),
  ];
  
  List<Person> result;
  
  try {
    result = await filterAndSortAdults(input);
  } catch (e) {
    print('Caught an exception of type ${e.runtimeType} \n while running filterAndSortAdults');
    return;
  }
  
  final errs = <String>[];
  
  // Check that only adults are included
  if (result.any((p) => p.age < 18)) {
    errs.add('The result includes people under 18');
  }
  
  // Check that all adults are included
  if (result.length != 3) {
    errs.add('Expected 3 adults, got ${result.length}');
  }
  
  // Check that the list is sorted by name
  final names = result.map((p) => p.name).toList();
  final sortedNames = List<String>.from(names)..sort();
  if (names.toString() != sortedNames.toString()) {
    errs.add('The list is not sorted by name');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}