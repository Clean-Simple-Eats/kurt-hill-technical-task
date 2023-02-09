abstract class Cache<Key, Value> {
  Future<void> setAsync(Key key, Value value);
  Future<Value?> getAsync(Key key);
  Future<List<Value>> getAllAsync();
}
