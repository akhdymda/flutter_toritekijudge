import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/judgment_providers.dart';

class JudgmentService {
  final Ref ref;
  JudgmentService(this.ref);

  void judgeTransaction() {
    final transactionType = ref.read(transactionTypeProvider);
    final ownCapital = ref.read(ownCapitalProvider);
    final ownEmployees = ref.read(ownEmployeesProvider);
    final partnerCapital = ref.read(partnerCapitalProvider);
    final partnerEmployees = ref.read(partnerEmployeesProvider);

    // バリデーション
    if (transactionType == null || ownCapital == null || ownEmployees == null || 
        partnerCapital == null || partnerEmployees == null) {
      ref.read(judgmentErrorProvider.notifier).state = 'すべての情報を入力してください。';
      ref.read(judgmentResultProvider.notifier).state = null;
      return;
    }

    // 判定ロジック実行
    final result = _executeJudgment(transactionType, ownCapital, ownEmployees, partnerCapital, partnerEmployees);
    
    ref.read(judgmentResultProvider.notifier).state = result;
    ref.read(judgmentErrorProvider.notifier).state = null;
  }

  String _executeJudgment(String transactionType, int ownCapital, int ownEmployees, int partnerCapital, int partnerEmployees) {
    String result = "中小受託取引に非該当"; // デフォルト

    final type1Transactions = ["製造委託", "修理委託", "特定運送委託", "情報成果物作成委託（プログラムの作成）"];
    final type2Transactions = ["情報成果物作成委託（プログラムの作成以外）", "役務提供委託"];

    if (type1Transactions.contains(transactionType)) {
      if (ownCapital > 300000000) {
        if (partnerCapital <= 300000000) {
          result = "中小受託取引に該当";
        } else {
          if (ownEmployees > 300 && partnerEmployees <= 300) {
            result = "中小受託取引に該当";
          }
        }
      } else if (ownCapital > 10000000 && ownCapital <= 300000000) {
        if (partnerCapital <= 10000000) {
          result = "中小受託取引に該当";
        } else {
          if (ownEmployees > 300 && partnerEmployees <= 300) {
            result = "中小受託取引に該当";
          }
        }
      }
    } else if (type2Transactions.contains(transactionType)) {
      if (ownCapital > 50000000) {
        if (partnerCapital <= 50000000) {
          result = "中小受託取引に該当";
        } else {
          if (ownEmployees > 100 && partnerEmployees <= 100) {
            result = "中小受託取引に該当";
          }
        }
      } else if (ownCapital > 10000000 && ownCapital <= 50000000) {
        if (partnerCapital <= 10000000) {
          result = "中小受託取引に該当";
        } else {
          if (ownEmployees > 100 && partnerEmployees <= 100) {
            result = "中小受託取引に該当";
          }
        }
      }
    }

    return result;
  }

  void clearForm() {
    ref.read(transactionTypeProvider.notifier).state = null;
    ref.read(ownCapitalProvider.notifier).state = null;
    ref.read(ownEmployeesProvider.notifier).state = null;
    ref.read(partnerCapitalProvider.notifier).state = null;
    ref.read(partnerEmployeesProvider.notifier).state = null;
    ref.read(judgmentResultProvider.notifier).state = null;
    ref.read(judgmentErrorProvider.notifier).state = null;
  }
}
