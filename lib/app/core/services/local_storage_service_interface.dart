typedef JsonMap = Map<String, dynamic>;

class LocalStorageException implements Exception {
  final String operation;
  final String key;
  final Object error;
  final StackTrace stackTrace;

  const LocalStorageException({
    required this.operation,
    required this.key,
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() {
    return 'LocalStorageException: failed to $operation "$key". Error: $error';
  }
}

abstract class ILocalStorageService {
  Future<JsonMap?> get(String key);

  Future<bool> set(String key, JsonMap value);

  Future<bool> put(String key, JsonMap Function(JsonMap old) construct);
}
