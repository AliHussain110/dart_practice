Future<int> sumStream(Stream<int> stream) async{

    int sum = 0;
    await for(int value in stream){
        sum+=value;
    }
    return sum;
}


Stream<int> countingStream(int to) async* {
    for(int i=0; i <= to; i++){ 
        yield i;
    }
}

void main()async{
    final stream = countingStream(10);
    final number = await sumStream(stream);
    print(number);
}