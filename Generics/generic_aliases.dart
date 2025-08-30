
typedef squareOfNumber<T> = T Function(T item);

void main() {
  // Use the alias to declare a function variable
  squareOfNumber<int> doubler = (x) => x * x;
  print(doubler(5)); // Output: 25
}
