import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/judgment_service.dart';

// 判定フォーム用状態管理
final transactionTypeProvider = StateProvider<String?>((ref) => null);
final ownCapitalProvider = StateProvider<int?>((ref) => null);
final ownEmployeesProvider = StateProvider<int?>((ref) => null);
final partnerCapitalProvider = StateProvider<int?>((ref) => null);
final partnerEmployeesProvider = StateProvider<int?>((ref) => null);
final judgmentResultProvider = StateProvider<String?>((ref) => null);
final judgmentErrorProvider = StateProvider<String?>((ref) => null);

// 判定サービス
final judgmentServiceProvider = Provider<JudgmentService>((ref) {
  return JudgmentService(ref);
});