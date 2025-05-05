import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ref_listen_exception_handler_sample/data/repositories/exception.dart';
import 'package:ref_listen_exception_handler_sample/domain/models/user.dart';
import 'package:ref_listen_exception_handler_sample/use_case/executors/repositories/user/create_user_executor.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

// 入力されたユーザーと仮定
  static const _user = User(
    id: '1',
    name: 'test',
    email: 'test@example.com',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザー作成処理のエラーを監視
    _createUserExceptionHandler(context, ref);
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

extension on HomeScreen {
  /// ユーザー作成ボタンを押したときの処理
  Future<void> _onCreateUserButtonPressed(
    BuildContext context,
    WidgetRef ref,
    User user,
  ) async {
    // ユーザー作成処理を実行
    await ref.read(createUserExecutorProvider.notifier).call(user);

    // stateのエラー状態を取得
    final hasError = ref.read(createUserExecutorProvider).hasError;

    // エラーの場合は中断
    if (hasError || !context.mounted) return;

    // 成功時の処理
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User created successfully')),
    );
  }

  /// ユーザー作成処理のエラーをハンドリングする
  void _createUserExceptionHandler(
    BuildContext context,
    WidgetRef ref,
  ) {
    // createUserExecutorProviderの状態を監視
    ref.listen(
      createUserExecutorProvider,
      (_, next) {
        // ローディング中でエラーが発生していない場合は何もしない
        if (next.isLoading && next.hasError == false) return;

        // エラーが発生している場合はハンドリングする
        if (next.error case final exception? when exception is Exception) {
          switch (exception) {
            case DuplicateUserNameException():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Duplicate user name')),
              );
            case ServerErrorException():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Server error')),
              );
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An unexpected error occurred')),
              );
          }
        }
      },
    );
  }
}
