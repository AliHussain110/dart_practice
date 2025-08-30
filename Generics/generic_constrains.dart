class NumberCache<T extends num> {
  final Map<String, T> _cache = {};
  
  void set(String key, T value) {
    _cache[key] = value;
  }
  
  T? get(String key) => _cache[key];
}

void main(){
// Works with int and double (both extend num)
NumberCache<int> intCache = NumberCache();
NumberCache<double> doubleCache = NumberCache();

// Won't work with String (doesn't extend num)
// NumberCache<String> stringCache = NumberCache(); // Compile-time error
}