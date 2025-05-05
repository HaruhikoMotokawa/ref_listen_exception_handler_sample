import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ref_listen_exception_handler_sample/data/repositories/exception.dart';
import 'package:ref_listen_exception_handler_sample/domain/models/user.dart';
import 'package:ref_listen_exception_handler_sample/presentation/screens/example/view_model.dart';

class ExampleScreen extends ConsumerWidget {
  const ExampleScreen({super.key});

// 入力されたユーザーと仮定
  static const _user = User(
    id: '1',
    name: 'test',
    email: 'test@example.com',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _onCreateUserButtonPressed(context, ref, _user),
          child: const Text('Create User'),
        ),
      ),
    );
  }
}

extension on ExampleScreen {
  /// ユーザー作成ボタンを押したときの処理
  Future<void> _onCreateUserButtonPressed(
    BuildContext context,
    WidgetRef ref,
    User user,
  ) async {
    // 失敗の可能性がある処理を実行
    try {
      // ユーザー作成処理を実行
      await ref.read(exampleViewModelProvider.notifier).createUser(user);

      if (!context.mounted) return;
      // 成功時の処理
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User created successfully')),
      );
      //エラー発生時の処理 1
    } on DuplicateUserNameException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      //エラー発生時の処理 2
    } on ServerErrorException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      //エラー発生時の処理 3
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
