/// Abstract local storage service interface
abstract interface class ILocalStorageService {
  /// Writes a value to the given box using the provided key.
  Future<void> write<T>(String boxName, String key, T value);

  /// Reads a value of type T from the given box using the key.
  Future<T?> read<T>(String boxName, String key);

  /// Deletes a specific key from the box.
  Future<void> delete(String boxName, String key);

  /// Clears all key-value pairs in the box.
  Future<void> clearBox(String boxName);

  /// Returns all values of type T from the given box.
  Future<List<T>> getAll<T>(String boxName);
}
