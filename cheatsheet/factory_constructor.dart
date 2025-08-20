// Replace the line TODO(); in the factory constructor named
// IntegerHolder.fromList to return the following:

// If the list has one value, create an IntegerSingle instance using that value.
// If the list has two values, create an IntegerDouble instance using the values in order.
// If the list has three values, create an IntegerTriple instance using the values in order.
// Otherwise, throw an Error.

class IntegerHolder {
  IntegerHolder();

  // Implement this factory constructor.
  factory IntegerHolder.fromList(List<int> list) {
//     TODO();
    switch(list.length){
      case 1:
        return IntegerSingle(1);
      
      case 2:
        return IntegerDouble(1,2);
      
      case 3:
        return IntegerTriple(1,2,3);
      
        default :
      throw ArgumentError("List must between 1 and 3 items. This list was ${list.length} items.");
        
    }
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;

  IntegerSingle(this.a);
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;

  IntegerDouble(this.a, this.b);
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;

  IntegerTriple(this.a, this.b, this.c);
}

void main() {
  final errs = <String>[];

  // Run 5 tests to see which values have valid integer holders.
  for (var tests = 0; tests < 5; tests++) {
    if (!testNumberOfArgs(errs, tests)) return;
  }

  // The goal is no errors with values 1 to 3,
  // but have errors with values 0 and 4.
  // The testNumberOfArgs method adds to the errs array if
  // the values 1 to 3 have an error and
  // the values 0 and 4 don't have an error.
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}

bool testNumberOfArgs(List<String> errs, int count) {
  bool _threw = false;
  final ex = List.generate(count, (index) => index + 1);
  final callTxt = "IntegerHolder.fromList(${ex})";
  try {
    final obj = IntegerHolder.fromList(ex);
    final String vals = count == 1 ? "value" : "values";
    // Uncomment the next line if you want to see the results realtime
    // print("Testing with ${count} ${vals} using ${obj.runtimeType}.");
    testValues(errs, ex, obj, callTxt);
  } on Error {
    _threw = true;
  } catch (e) {
    switch (count) {
      case (< 1 && > 3):
        if (!_threw) {
          errs.add('Called ${callTxt} and it didn\'t throw an Error.');
        }
      default:
        errs.add('Called $callTxt and received an Error.');
    }
  }
  return true;
}

void testValues(List<String> errs, List<int> expectedValues, IntegerHolder obj,
    String callText) {
  for (var i = 0; i < expectedValues.length; i++) {
    int found;
    if (obj is IntegerSingle) {
      found = obj.a;
    } else if (obj is IntegerDouble) {
      found = i == 0 ? obj.a : obj.b;
    } else if (obj is IntegerTriple) {
      found = i == 0
          ? obj.a
          : i == 1
              ? obj.b
              : obj.c;
    } else {
      throw ArgumentError(
          "This IntegerHolder type (${obj.runtimeType}) is unsupported.");
    }

    if (found != expectedValues[i]) {
      errs.add(
          "Called $callText and got a ${obj.runtimeType} " +
          "with a property at index $i value of $found " +
          "instead of the expected (${expectedValues[i]}).");
    }
  }
}