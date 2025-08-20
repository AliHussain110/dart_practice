// Remember the Color class from above?
// Create a named constructor called black,
// but rather than manually assigning the properties,
// redirect it to the default constructor with zeros as the arguments.

class Color {
  int red;
  int green;
  int blue;

  Color(this.red, this.green, this.blue);

  // TODO: Create a named constructor called "black" here
  // and redirect it to call the existing constructor
  Color.black(): this(0,0,0);
}

void main() {
  final errs = <String>[];

  try {
    final result = Color.black();

    if (result.red != 0) {
      errs.add('Called Color.black() and got a Color with red equal to \n ${result.red} instead of the expected value (0).');
    }

    if (result.green != 0) {
      errs.add('Called Color.black() and got a Color with green equal to \n ${result.green} instead of the expected value (0).');
    }

    if (result.blue != 0) {
  errs.add('Called Color.black() and got a Color with blue equal to \n ${result.blue} instead of the expected value (0).');
    }
  } catch (e) {
    print('Called Color.black() and got an exception of type ${e.runtimeType}.');
    return;
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}