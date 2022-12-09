## プロジェクト名
### Movice

## 概要
映画の情報をウォッチリストに追加して、保存することができる。

apple store: https://apps.apple.com/app/movice/id6443401413

## 環境構築
1. リポジトリをclone 

- *git clone https://github.com/atsuki-uenishi/movice*

2. cocoapodsをインストール 

- *sudo gem install cocoapods*

3. cocoapodsをセットアップ

- *pod setup*

4. ライブラリのインストール

- *pod install

##開発情報

| 項目 | バージョン |
| ---- | ---- |
| Xcode | 13.3.1 |
| Swift | 5.5.2 |
| iOS | 13.0以上 |
| CocoaPods | 1.11.2 |
| Swiftlint | 0.49.1 |
| RealmSwift | 10.28.6 |
| Moya | 15.0.0 |
| Cosmos | 23.0.0 |
| Nuke | 10.7.1 | 
| Snackbar | 0.1.0 |
| SwiftGen | 6.6.2 |

## 使用ライブラリ
*Realm Swift*

モバイルデータベースへのアクセスを行う。

*Moya*

API通信を行うライブラリです。

*Cosmos*

レーティングUIを作成するためのライブラリです。

*Nuke*

画像ロードのライブラリです。

*Snackbar*

Snackbarを作成するためのライブラリです。

## バージョン管理
GitHubを使用

## デザインパターン
MVCモデルを使用
