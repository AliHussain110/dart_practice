import 'dart:async';
import 'dart:isolate';

// ===============================================
// SECTION 1: Null Safety & Basic Dart (15 points)
// ===============================================

// 1.1 Safe string to int
int? safeStringToInt(String input) {
  try {
    return int.parse(input);
  } catch (_) {
    return null;
  }
}

// 1.2 Product class with null safety
class Product {
  final String name;
  final double? price; // nullable
  final List<String> tags;

  Product(this.name, this.price, this.tags);

  String getPriceText() {
    return price == null ? "Free" : "\$${price!.toStringAsFixed(2)}";
  }
}

// 1.3 Fix null safety in loop
void testSection1() {
  List<int?> numbers = [1, 2, null, 4];
  int sum = 0;

  for (var num in numbers) {
    if (num != null) {
      sum += num;
    }
  }
  print("Sum: $sum");
}

// ===============================================
// SECTION 2: Object-Oriented Programming (20 points)
// ===============================================

// 2.1 Abstract class and implementations
abstract class Animal {
  String name;

  Animal(this.name);

  void makeSound();

  void eat() {
    print("$name is eating");
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print("$name says: Woof!");
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print("$name says: Meow!");
  }
}

// 2.2 Mixin
mixin Flyable {
  void fly() {
    print("I'm flying!");
  }
}

class Bird with Flyable {
  String name;

  Bird(this.name);

  void chirp() {
    print("$name is chirping");
  }
}

// ===============================================
// SECTION 3: Async Programming (25 points)
// ===============================================

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

Future<User> fetchUser(String userId) async {
  await Future.delayed(Duration(seconds: 1));
  if (userId == "error") throw Exception("User not found");
  return User("John Doe", "john@example.com");
}

Future<String> getUserInfo(String userId) async {
  try {
    final user = await fetchUser(userId);
    return "User: ${user.name}, Email: ${user.email}";
  } catch (e) {
    return "Error: ${e.toString()}";
  }
}

Stream<int> createNumberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}

Stream<int> createEvenNumberStream() {
  return createNumberStream().where((num) => num % 2 == 0);
}

// Difference between Future and Stream:
// Future → represents a single asynchronous result (one-time event).
// Stream → represents a sequence of asynchronous results (multiple events over time).

// ===============================================
// SECTION 4: Functional Programming (15 points)
// ===============================================

void processNumbers() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  numbers
      .map((n) => n * 2)
      .where((n) => n > 5)
      .take(3)
      .forEach((n) => print(n));
}

T applyOperation<T>(T Function(T, T) operation, T a, T b) {
  return operation(a, b);
}

// ===============================================
// SECTION 5: Generics (10 points)
// ===============================================

class Cache<T> {
  final Map<String, T> _storage = {};

  void put(String key, T value) => _storage[key] = value;

  T? get(String key) => _storage[key];

  bool containsKey(String key) => _storage.containsKey(key);

  void clear() => _storage.clear();
}

// ===============================================
// SECTION 6: Isolates (15 points)
// ===============================================

Future<int> computeSumInIsolate(List<int> numbers) async {
  final p = ReceivePort();
  await Isolate.spawn(_computeSum, [p.sendPort, numbers]);
  return await p.first;
}

void _computeSum(List<dynamic> args) {
  SendPort sendPort = args[0];
  List<int> numbers = args[1];
  int sum = numbers.fold(0, (a, b) => a + b);
  sendPort.send(sum);
}

// ===============================================
// SECTION 7: Error Handling (10 points)
// ===============================================

class InvalidAgeException implements Exception {
  final String message;
  InvalidAgeException(this.message);

  @override
  String toString() => message;
}

void validateAge(int age) {
  if (age < 0 || age > 150) {
    throw InvalidAgeException("Invalid age: $age");
  }
}

void testAgeValidation(int age) {
  try {
    validateAge(age);
    print("Valid age");
  } catch (e) {
    print(e);
  }
}

// ===============================================
// SECTION 8: Extensions (10 points)
// ===============================================

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  bool get isPalindrome {
    final clean = toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return clean == clean.split('').reversed.join();
  }

  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return substring(0, maxLength) + "...";
  }
}

// ===============================================
// SECTION 9: Practical Problem (30 points)
// ===============================================

class Task {
  final String id;
  String title;
  String description;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TaskManager {
  final List<Task> _tasks = [];
  final StreamController<List<Task>> _taskStreamController =
      StreamController.broadcast();

  void _notify() {
    _taskStreamController.add(List.unmodifiable(_tasks));
  }

  void addTask(Task task) {
    _tasks.add(task);
    _notify();
  }

  void updateTask(String id, {String? title, String? description}) {
    final task = _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception("Task not found"),
    );
    if (title != null) task.title = title;
    if (description != null) task.description = description;
    _notify();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    _notify();
  }

  List<Task> getAllTasks() => List.unmodifiable(_tasks);

  List<Task> getCompletedTasks() => _tasks.where((t) => t.isCompleted).toList();

  List<Task> getPendingTasks() => _tasks.where((t) => !t.isCompleted).toList();

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception("Task not found"),
    );
    task.isCompleted = !task.isCompleted;
    _notify();
  }

  Stream<List<Task>> get taskStream => _taskStreamController.stream;

  void dispose() {
    _taskStreamController.close();
  }
}

// ===============================================
// TESTING IMPLEMENTATION
// ===============================================

void main() async {
  // print("=== Section 1 ===");
  // print(safeStringToInt("123"));
  // print(safeStringToInt("abc"));
  // testSection1();
  // Product p1 = Product("Book", null, ["education"]);
  // print(p1.getPriceText());

  // print("\n=== Section 2 ===");
  // Dog d = Dog("Buddy");
  // d.makeSound();
  // d.eat();
  // Cat c = Cat("Kitty");
  // c.makeSound();
  // Bird b = Bird("Tweety");
  // b.chirp();
  // b.fly();

  // print("\n=== Section 3 ===");
  // print(await getUserInfo("123"));
  // print(await getUserInfo("error"));
  // await for (var n in createNumberStream()) {
  //   print("Number: $n");
  // }
  // await for (var n in createEvenNumberStream()) {
  //   print("Even: $n");
  // }

  // print("\n=== Section 4 ===");
  // processNumbers();
  // print(applyOperation<int>((a, b) => a + b, 5, 3));

  // print("\n=== Section 5 ===");
  // var cache = Cache<int>();
  // cache.put("a", 10);
  // print(cache.get("a"));
  // print(cache.containsKey("a"));
  // cache.clear();

  // print("\n=== Section 6 ===");
  // print(await computeSumInIsolate([1, 2, 3, 4, 5]));

  // print("\n=== Section 7 ===");
  // testAgeValidation(25);
  // testAgeValidation(-5);

  // print("\n=== Section 8 ===");
  // print("hello".capitalize());
  // print("racecar".isPalindrome);
  // print("longtext".truncate(4));

  print("\n=== Section 9 ===");
  TaskManager manager = TaskManager();
  manager.addTask(Task(id: "1", title: "Do HW", description: "Math homework"));
  manager.addTask(Task(id: "3", title: "Do HW", description: "Math homework"));
  manager.addTask(Task(id: "4", title: "Do HW", description: "Math homework"));
  manager.addTask(Task(id: "5", title: "Do HW", description: "Math homework"));
  manager.addTask(
    Task(id: "2", title: "Flutter project", description: "Work on app"),
  );
  manager.toggleTaskCompletion("1");
  print(manager.getAllTasks().map((t) => t.title).toList());
  print(manager.getCompletedTasks().map((t) => t.title).toList());
  print(manager.getPendingTasks().map((t) => t.title).toList());
}
