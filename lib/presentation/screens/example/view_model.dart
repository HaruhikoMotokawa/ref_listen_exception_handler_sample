import 'package:ref_listen_exception_handler_sample/data/repositories/provider.dart';
import 'package:ref_listen_exception_handler_sample/domain/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class ExampleViewModel extends _$ExampleViewModel {
  @override
  void build() {}

  Future<void> createUser(User user) =>
      ref.read(userRepositoryProvider).create(user);

  Future<void> updateUser() async {
    // ...
  }

  Future<void> deleteUser() async {
    // ...
  }
}
