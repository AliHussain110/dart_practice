void main(){
  int add(int a, int b) => a+b;
  int subtract(int a, int b) => a-b;

  Function operation = add;
  print(operation(5,5));

  operation = subtract;
  print(operation(10,5));
}