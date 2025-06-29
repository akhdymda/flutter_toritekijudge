import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import 'login_page.dart';
import 'judgment_page.dart';

// 認証ラッパー
class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          print('Auth state: ログイン済みです ${user.email}');
          return JudgmentPage();
        } else {
          print('Auth state: 未ログイン');
        return LoginPage();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('認証エラー: $error'),
        ),
      ),
    );
  }
}