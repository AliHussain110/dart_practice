import 'dart:isolate';

  int getSum(){
    int sum = 0;
    for(int i=0;i<=10;i++){
      sum+=i;
    }
    return sum;

  }

void main() async{
  print('starting main');
  final response = await Isolate.run(getSum);
  print('waiting for response');
  print(response);
}