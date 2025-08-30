void main(){
  // Without generics - less type-safe
List items = [1, 'two', 3.0]; // Mixed types allowed

// With generics - type-safe
List<int> numbers = [1, 2, 3]; // Only integers allowed
List<String> names = ['Ali Hussain', 'Dart']; // Only strings allowed

}