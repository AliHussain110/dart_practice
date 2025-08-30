typedef IntOperation = int Function(int, int);

int add(int a, int b) => a + b;
int multiply(int a, int b) => a * b;

void executeOperation(int a, int b, IntOperation op) {
  print(op(a, b));
}

void main(){
executeOperation(5, 3, add);      // 8
executeOperation(5, 3, multiply); // 15
}
