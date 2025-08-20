// Add a copyWith() instance method to the MyDataObject class.
// It should take three named, nullable parameters:

// int? newInt
// String? newString
// double? newDouble
// Your copyWith() method should return a new MyDataObject based on
// the current instance, with data from the preceding parameters 
// (if any) copied into the object's properties. For example,
// if newInt is non-null, then copy its value into anInt.

class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
     this.anInt = 1,
     this.aString = 'Old!',
     this.aDouble = 2.0,
  });

  MyDataObject copyWith({int? newInt, String? newString,double? newDouble}){
    return MyDataObject(anInt: newInt ?? this.anInt, aString: newString ?? this.aString, aDouble: newDouble ?? this.aDouble);
  }
  // TODO: Add your copyWith method here:
}

void main() {
  final source = MyDataObject();
  final errs = <String>[];

  try {
    final copy = source.copyWith(newInt: 12, newString: 'New!', newDouble: 3.0);

    if (copy.anInt != 12) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s anInt was ${copy.anInt} rather than the expected value (12).');
    }

    if (copy.aString != 'New!') {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s aString was ${copy.aString} rather than the expected value (\'New!\').');
    }

    if (copy.aDouble != 3) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (3).');
    }
  } catch (e) {
    print('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0) \n and got an exception: ${e.runtimeType}');
  }

  try {
    final copy = source.copyWith();

    if (copy.anInt != 1) {
      errs.add('Called copyWith(), and the new object\'s anInt was ${copy.anInt} \n rather than the expected value (1).');
    }

    if (copy.aString != 'Old!') {
      errs.add('Called copyWith(), and the new object\'s aString was ${copy.aString} \n rather than the expected value (\'Old!\').');
    }

    if (copy.aDouble != 2) {
      errs.add('Called copyWith(), and the new object\'s aDouble was ${copy.aDouble} \n rather than the expected value (2).');
    }
  } catch (e) {
    print('Called copyWith() and got an exception: ${e.runtimeType}');
  }

  try {
    final sourceWithoutDefaults = MyDataObject(
      anInt: 520,
      aString: 'Custom!',
      aDouble: 20.25,
    );
    final copy = sourceWithoutDefaults.copyWith();

    if (copy.anInt == 1) {
      errs.add('Called `copyWith()` on an object with a non-default `anInt` value (${sourceWithoutDefaults.anInt}), but the new object\'s `anInt` was the default value of ${copy.anInt}.');
    }

    if (copy.aString == 'Old!') {
      errs.add('Called `copyWith()` on an object with a non-default `aString` value (\'${sourceWithoutDefaults.aString}\'), but the new object\'s `aString` was the default value of \'${copy.aString}\'.');
    }

    if (copy.aDouble == 2.0) {
      errs.add('Called copyWith() on an object with a non-default `aDouble` value (${sourceWithoutDefaults.aDouble}), but the new object\'s `aDouble` was the default value of ${copy.aDouble}.');
    }
  } catch (e) {
    print('Called copyWith() and got an exception: ${e.runtimeType}');
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}