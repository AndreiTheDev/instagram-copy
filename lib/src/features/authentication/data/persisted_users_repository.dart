import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/logger.dart';
import 'entities/user_entity.dart';

part 'persisted_users_repository.g.dart';

@riverpod
PersistedUsersRepository persistedUsersRepository(
  final PersistedUsersRepositoryRef ref,
) =>
    PersistedUsersRepository();

class PersistedUsersRepository {
  //init
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final _logger = getLogger(PersistedUsersRepository);

  Future<void> addUser(final UserEntity entity) async {
    try {
      final bool isUserInStorage = await _storage.containsKey(key: entity.uid);
      if (!isUserInStorage) {
        await _storage.write(
          key: entity.uid,
          value: jsonEncode(entity.toJson()),
        );
      }
    } on Exception catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> deleteUser(final String uid) async {
    try {
      await _storage.delete(key: uid);
    } on Exception catch (e) {
      _logger.e(e.toString());
    }
    // return getAllUsers();
  }

  Future<List<UserEntity>> getAllUsers() async {
    try {
      final response = await _storage.readAll();
      final List<UserEntity> usersInStorage = response.entries
          .map((e) => UserEntity.fromJson(jsonDecode(e.value)))
          .toList();
      return usersInStorage;
    } on Exception catch (e) {
      _logger.e(e.toString());
      return <UserEntity>[];
    }
  }
}
