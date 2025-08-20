// The following function takes two integers as parameters.
// Make it return a string containing both integers separated by a space.
// For example, stringify(2, 3) should return '2 3'.

String stringify(int x, int y) {
  return '$x $y';
}


// Tests
void main() {
  assert(stringify(2, 3) == '2 3',
      "Your stringify method returned '${stringify(2, 3)}' instead of '2 3'");
  print('Success!');
}
