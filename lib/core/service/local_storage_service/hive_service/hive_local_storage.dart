import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_album/core/service/local_storage_service/local_storage_service_interface.dart';

/// Hive-based implementation of the local storage service.
final class HiveLocalStorageService implements ILocalStorageService {
  const HiveLocalStorageService();

  /// Opens a box with the given name, reuses it if already open.
  Future<Box> _openBox(String name) async {
    if (Hive.isBoxOpen(name)) return Hive.box(name);
    return await Hive.openBox(name);
  }

  @override
  Future<void> write<T>(String boxName, String key, T value) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> read<T>(String boxName, String key) async {
    final box = await _openBox(boxName);
    return box.get(key) as T?;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    final box = await _openBox(boxName);
    await box.clear();
  }

  @override
  Future<List<T>> getAll<T>(String boxName) async {
    final box = await _openBox(boxName);
    return box.values.cast<T>().toList();
  }
}
