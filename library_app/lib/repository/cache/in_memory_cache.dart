import 'package:library_app/repository/cache/cache.dart';

class InMemoryCache<Key, Value> implements Cache<Key, Value> {
  final cache = <Key, Value>{};

  @override
  Future<Value?> getAsync(Key key) async {
    return cache[key];
  }

  @override
  Future<void> setAsync(Key key, Value value) async {
    cache[key] = value;
  }

  @override
  Future<List<Value>> getAllAsync() async {
    return cache.values.toList();
  }
}
