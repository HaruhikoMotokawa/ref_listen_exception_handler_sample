# ref_listen_exception_handler_sample

## 概要
このプロジェクトは、`AsyncValue`と`ref_listen`を使用した実行処理と例外処理の分離を目的としたFlutterアプリケーションです。

詳細な解説は以下の記事をご覧ください。

https://zenn.dev/harx/articles/4a336e8b75ac3c

## 実行手順
build_runnerの成果物は差分監視対象外です。
次のコマンドを実行して行動生成後にビルドしてください。

```
flutter pub run build_runner build --delete-conflicting-outputs
```

derryをインストール済みの方は以下のコマンドでも実行可能です。

```
derry build
```
