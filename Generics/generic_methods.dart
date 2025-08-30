
T getFirstElement<T>(List<T> list){
  return list.isNotEmpty ? list[0] : throw Exception('empty List');

}

void main(){
  // Usage with different types
print(getFirstElement([1, 2, 3])); // 1
print(getFirstElement(['a', 'b', 'c'])); // a

}