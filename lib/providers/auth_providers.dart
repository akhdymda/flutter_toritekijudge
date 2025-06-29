import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// 認証情報を監視するStreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// 現在のユーザーを取得するProvider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenData((user) => user).value;
});

// ユーザー入力状態管理
final emailProvider = StateProvider<String>((ref)  => '');
final passwordProvider = StateProvider<String>((ref) => '');
final errorMessageProvider = StateProvider<String>((ref) => '');

// 認証サービス
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});