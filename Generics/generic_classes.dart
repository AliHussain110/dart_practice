class Box<T> {
  T content;
  Box(this.content);
  T get getContent => content;
}
void main(){
// usage with different types
Box<int> intBox = Box(392);
Box<String> stringBox = Box('Ali Hussain');
Box<List<bool>> listBox = Box([true, false]);

print(intBox.getContent); // 392
print(stringBox.getContent); // Ali Hussain
print(listBox.getContent); // [true, false]
}