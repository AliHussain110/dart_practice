int add(int a, int b) => a+b;
int subtract(int a, int b) => a-b;

Function makeMultiplier(int factor) {
  return (int value) => value * factor;
}
void main(){
var doubler = makeMultiplier(2);
var tripler = makeMultiplier(3);
  Function operation = add;
print(operation(5,5));

  operation = subtract;
print(operation(10,5));

print(doubler(5)); // 10
print(tripler(5)); // 15
}