void main(){
var add = (int a,int b) => a + b;
print(add(5,10));

// with multiple statements

var complex = (int x, int y){
  int sum = x + y;
  int product = x * y;
  return sum + product;
};
print(complex(2,3));

}
