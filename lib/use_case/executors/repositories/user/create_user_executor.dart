import 'package:ref_listen_exception_handler_sample/data/repositories/provider.dart';
import 'package:ref_listen_exception_handler_sample/domain/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user_executor.g.dart';

@riverpod
class CreateUserExecutor extends _$CreateUserExecutor {
  @override
  Future<void> build() async {}

  Future<void> call(User user) async =>
      state = await AsyncValue.guard(() async {
        await ref.read(userRepositoryProvider).create(user);
      });
}
