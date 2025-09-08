abstract class Cache<K, V> {
  void set(K key, V value);
  V? get(K key);
  void clear();
}

mixin TimeStampedCache {
  DateTime? _lastUpdate;
  Duration? get timeSinceLastUpdate =>
      _lastUpdate != null ? DateTime.now().difference(_lastUpdate!) : null;
}

class InMemoryCache<K, V> with TimeStampedCache implements Cache<K, V> {
  final Map<K, V> _cache = {};
  @override
  void set(K key, V value) {
    _cache[key] = value;
    _lastUpdate = DateTime.now();
  }

  @override
  V? get(K key) => _cache[key];

  @override
  void clear() => _cache.clear();
  Iterable<V> get values => _cache.values;
}

extension IntCacheUtils on InMemoryCache<String, int> {
  int get sumOfValues => this.values.fold(0, (k, v) => k + v);
}
void main() {
  var userScoreCache = InMemoryCache<String, int>();
  userScoreCache.set('player1', 100);
  userScoreCache.set('player2', 250);

  print('Player 2 score: ${userScoreCache.get('player2')}'); // Expected: 250
  print('Total score: ${userScoreCache.sumOfValues}'); // Expected: 350

  // Test the mixin
  Future.delayed(Duration(seconds: 1), () {
    print('Time since last update: ${userScoreCache.timeSinceLastUpdate}');
    // Expected: ~1 second
  });
}