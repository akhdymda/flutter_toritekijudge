# Flutter_中小取引適正化法適用判定アプリ

## 概要
このアプリは、中小取引適正化法の適用判定を行うためのアプリです。

## フォルダ構成
lib/
├── main.dart                    # アプリのエントリーポイントのみ
├── providers/
│   ├── auth_providers.dart      # 認証関連プロバイダー
│   └── judgment_providers.dart  # 判定関連プロバイダー
├── services/
│   ├── auth_service.dart        # 認証サービス
│   └── judgment_service.dart    # 判定サービス
├── screens/
│   ├── auth_wrapper.dart        # 認証ラッパー
│   ├── login_page.dart          # ログイン画面
│   ├── judgment_page.dart       # 判定画面
├── widgets/
│   └── common_widgets.dart      # 共通ウィジェット
└── firebase_options.dart       # Firebase設定（既存）

## 使用技術
- Flutter
- Riverpod
- Firebase Authentication
- Firebase Firestore

## 開発環境
- Flutter 3.20.0

## 画面構成
- ログイン画面
![ログイン画面](./images/login_page.png)

- 判定画面
![判定画面](./images/judgment_page.png)

## ログイン
- ログイン画面でメールアドレスとパスワードを入力してログインします。

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
