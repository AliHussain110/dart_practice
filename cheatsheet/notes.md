📘 Dart Language Notes

1. String Interpolation

**Def:** Insert expressions inside strings using `${expression}` or `$variable`.
**Example:**

```dart
print('${3 + 2}'); // 5
print('${"dart".toUpperCase()}'); // DART
print('$name'); // value of name.toString()
```

---

### 2. Nullable Variables

**Def:** By default, variables can’t be `null`. Add `?` to allow null values.
**Example:**

```dart
int? a = null;  
String? name = "Ali";  
```

---

### 3. Null-aware Operators

**Def:** Operators that handle null values safely.

* `??=` → assign only if variable is null
* `??` → return left if not null, else right
  **Example:**

```dart
int? a;
a ??= 3; // a = 3
print(1 ?? 5); // 1
print(null ?? 12); // 12
```

---

### 4. Conditional Property Access

**Def:** Use `?.` to safely access properties/methods of possibly null objects.
**Example:**

```dart
print(myObject?.name);  
```

---

### 5. Collection Literals

**Def:** Dart supports lists, sets, and maps with literals.
**Example:**

```dart
final list = ['one', 'two'];
final set = {'a', 'b'};
final map = {'one': 1, 'two': 2};
```

---

### 6. Arrow Syntax (=>)

**Def:** Short form for functions that return a single expression.
**Example:**

```dart
bool isEmpty(String s) => s.isEmpty;
```

---

### 7. Cascades (..) and (?..)

**Def:** Perform multiple operations on the same object.
**Example:**

```dart
var buffer = StringBuffer()
  ..write('Hello ')
  ..write('World!');
```

---

### 8. Getters and Setters

**Def:** Special methods to read (`get`) or modify (`set`) private fields.
**Example:**

```dart
class Person {
  String _name = "";
  String get name => _name;
  set name(String value) => _name = value;
}
```

---

### 9. Optional Positional Parameters

**Def:** Parameters wrapped in `[]` are optional.
**Example:**

```dart
int add(int a, [int b = 0]) => a + b;
print(add(2)); // 2
print(add(2, 3)); // 5
```

---

### 10. Named Parameters

**Def:** Parameters in `{}` can be passed by name, optional unless `required`.
**Example:**

```dart
void greet(String name, {int age = 0}) {
  print("Hi $name, age $age");
}
greet("Ali", age: 20);
```

---

### 11. Exceptions

**Def:** Errors are handled using `try`, `catch`, `on`, `finally`.
**Example:**

```dart
try {
  throw Exception("Error!");
} catch (e) {
  print(e);
} finally {
  print("Done");
}
```

---

### 12. Using `this` in Constructors

**Def:** Use `this.field` to assign constructor parameters to class fields.
**Example:**

```dart
class Point {
  int x, y;
  Point(this.x, this.y);
}
```

---

### 13. Initializer Lists

**Def:** Assign values before constructor body runs.
**Example:**

```dart
class Point {
  final int x, y;
  Point.fromJson(Map<String,int> json) : x = json['x']!, y = json['y']!;
}
```

---

### 14. Named Constructors

**Def:** Classes can have multiple constructors with different names.
**Example:**

```dart
class Point {
  int x, y;
  Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
}
```

---

### 15. Factory Constructors

**Def:** Can return different objects or subtypes.
**Example:**

```dart
class Shape {
  factory Shape(String type) {
    if (type == 'circle') return Circle();
    return Square();
  }
}
```

---

### 16. Redirecting Constructors

**Def:** Constructor redirects to another constructor.
**Example:**

```dart
class Car {
  Car(this.model);
  Car.electric() : this("Tesla");
}
```

---

### 17. Const Constructors

**Def:** Create compile-time constant objects using `const`.
**Example:**

```dart
class Point {
  final int x, y;
  const Point(this.x, this.y);
}
const origin = Point(0, 0);
```

