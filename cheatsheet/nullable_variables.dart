// Declare two variables in this DartPad:

// A nullable String named name with the value 'Jane'.
// A nullable String named address with the value null.

// TODO: Declare the two variables here
  String? name = 'Jane';
  String? address;

void main() {
  try {
    if (name == 'Jane' && address == null) {
      // Verify that "name" is nullable.
      name = null;
      print('Success!');
    } else {
      print('Not quite right, try again!');
    }
  } catch (e) {
    print('Exception: ${e.runtimeType}');
  }
}