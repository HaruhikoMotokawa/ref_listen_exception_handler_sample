import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ref_listen_exception_handler_sample/core/log/logger.dart';
import 'package:ref_listen_exception_handler_sample/data/repositories/exception.dart';
import 'package:ref_listen_exception_handler_sample/domain/models/user.dart';

class UserRepository {
  UserRepository(this.ref);
  final Ref ref;

  /// 新規作成
  Future<void> create(User user) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // 検証のためにわざと例外をthrowする
      _throwException();

      // ユーザーを作成する処理
      logger.d('create user: $user');
    } on DuplicateUserNameException catch (e) {
      throw DuplicateUserNameException(e.message);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.message);
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

extension on UserRepository {
  /// Exceptionをランダムにthrowする
  void _throwException() {
    final random = Random();

    final index = random.nextInt(_UserRepositoryError.values.length);
    switch (_UserRepositoryError.values[index]) {
      case _UserRepositoryError.firstException:
        throw DuplicateUserNameException('Duplicate user name');
      case _UserRepositoryError.serverError:
        throw ServerErrorException('Server error');
      case _UserRepositoryError.exception:
        throw Exception('An unexpected error occurred');
    }
  }
}

enum _UserRepositoryError {
  firstException,
  serverError,
  exception,
}
