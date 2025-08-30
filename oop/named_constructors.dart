class Rectangle {
  double width, height;
  
  Rectangle(this.width, this.height);
  
  // Named constructor
  Rectangle.square(double size) : this(size, size);
  
  // Factory constructor
  factory Rectangle.fromMap(Map<String, dynamic> map) {
    return Rectangle(
      (map['width'] as int).toDouble(), 
      (map['height'] as int).toDouble(),
    );
  }
}

void main() {
  var square = Rectangle.square(10);
  var fromMap = Rectangle.fromMap({'width': 5, 'height': 3});

  print('Square dimensions: ${square.width} x ${square.height}');
  print('Map dimensions: ${fromMap.width} x ${fromMap.height}');
}
