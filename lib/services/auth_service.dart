import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

// 認証サービスクラス
class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<void> signUp() async {
    try {
      final email = ref.read(emailProvider);
      final password = ref.read(passwordProvider);

      print('Attempting user registration for: $email');

      final auth = FirebaseAuth.instance;
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registration successful: ${result.user?.email}');
      ref.read(errorMessageProvider.notifier).state = '';

    } on FirebaseAuthException catch (e) {
      print('Registration error: $e');
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'このメールアドレスは既に登録されています。\nログインボタンをお試しください。';
          break;
        case 'invalid-email':
          errorMessage = 'メールアドレスの形式が正しくありません。';
          break;
        case 'weak-password':
          errorMessage = 'パスワードが弱すぎます。6文字以上で設定してください。';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/Passwordでのログインが無効になっています。';
          break;
        default:
          errorMessage = 'ユーザー登録に失敗しました\nエラーコード: ${e.code}\nメッセージ: ${e.message}';
      }
      ref.read(errorMessageProvider.notifier).state = errorMessage;
    } catch (e) {
      ref.read(errorMessageProvider.notifier).state = 'ユーザー登録に失敗しました: $e';
    }
  }

  Future<void> signIn() async {
    try {
      final email = ref.read(emailProvider);
      final password = ref.read(passwordProvider);

      print('Attempting user login for: $email');

      final auth = FirebaseAuth.instance;
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User login successful: ${result.user?.email}');
      ref.read(errorMessageProvider.notifier).state = '';

    } on FirebaseAuthException catch (e) {
      print('Login error: $e');
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'このメールアドレスは登録されていません。\nユーザー登録をお試しください。';
          break;
        case 'wrong-password':
          errorMessage = 'パスワードが間違っています。';
          break;
        case 'invalid-email':
          errorMessage = 'メールアドレスの形式が正しくありません。';
          break;
        case 'user-disabled':
          errorMessage = 'このアカウントは無効化されています。';
          break;
        case 'too-many-requests':
          errorMessage = 'リクエストが多すぎます。しばらく待ってからお試しください。';
          break;
        default:
          errorMessage = 'ログインに失敗しました\nエラーコード: ${e.code}\nメッセージ: ${e.message}';
      }
      ref.read(errorMessageProvider.notifier).state = errorMessage;
    } catch (e) {
      ref.read(errorMessageProvider.notifier).state = 'ログインに失敗しました: $e';
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Sign out error: $e');
      ref.read(errorMessageProvider.notifier).state = 'ログアウトに失敗しました: $e';
    }
  }
}