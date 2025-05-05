/// ユーザー名が重複している
class DuplicateUserNameException implements Exception {
  DuplicateUserNameException(this.message);
  final String message;

  @override
  String toString() {
    return 'DuplicateUserNameException: $message';
  }
}

/// サーバーエラー
class ServerErrorException implements Exception {
  ServerErrorException(this.message);
  final String message;

  @override
  String toString() {
    return 'ServerErrorException: $message';
  }
}
