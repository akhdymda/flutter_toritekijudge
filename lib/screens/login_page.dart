import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

//　ログイン画面
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(errorMessageProvider);
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力フォーム
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (value) {
                  ref.read(emailProvider.notifier).state = value;
                },
              ),
              // パスワード入力フォーム
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (value) {
                  ref.read(passwordProvider.notifier).state = value;
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => authService.signUp(),
                  child: const Text('ユーザー登録'),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => authService.signIn(),
                  child: const Text('ログイン'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}