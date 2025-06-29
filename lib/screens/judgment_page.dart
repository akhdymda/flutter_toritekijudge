import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../providers/judgment_providers.dart';

class JudgmentPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authService = ref.watch(authServiceProvider);
    final judgmentService = ref.watch(judgmentServiceProvider);
    
    final transactionType = ref.watch(transactionTypeProvider);
    final judgmentResult = ref.watch(judgmentResultProvider);
    final judgmentError = ref.watch(judgmentErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('取適法判定アプリ'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => judgmentService.clearForm(),
            tooltip: 'フォームをクリア',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authService.signOut(),
            tooltip: 'ログアウト',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ユーザー情報表示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text('ログイン中: ${user?.email ?? "不明"}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 取引内容選択
            const Text(
              '取引内容',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: '取引内容を選択してください',
                border: OutlineInputBorder(),
              ),
              value: transactionType,
              items: const [
                DropdownMenuItem(value: "製造委託", child: Text("製造委託")),
                DropdownMenuItem(value: "修理委託", child: Text("修理委託")),
                DropdownMenuItem(
                  value: "情報成果物作成委託（プログラムの作成）", 
                  child: Text("情報成果物作成委託（プログラムの作成）",
                    overflow: TextOverflow.ellipsis,
                  ) 
                ),
                DropdownMenuItem(
                  value: "情報成果物作成委託（プログラムの作成以外）", 
                  child: Text(
                    "情報成果物作成委託（プログラムの作成以外）",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(value: "役務提供委託", child: Text("役務提供委託")),
                DropdownMenuItem(value: "特定運送委託", child: Text("特定運送委託")),
              ],
              onChanged: (value) {
                ref.read(transactionTypeProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),

            // 自社情報
            const Text(
              '自社情報',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '自社の資本金（円）',
                hintText: '例: 100000000',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(ownCapitalProvider.notifier).state = int.tryParse(value);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '自社の従業員数（人）',
                hintText: '例: 100',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(ownEmployeesProvider.notifier).state = int.tryParse(value);
              },
            ),
            const SizedBox(height: 20),

            // 取引先情報
            const Text(
              '取引先情報',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '取引先の資本金（円）',
                hintText: '例: 10000000',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(partnerCapitalProvider.notifier).state = int.tryParse(value);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '取引先の従業員数（人）',
                hintText: '例: 50',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(partnerEmployeesProvider.notifier).state = int.tryParse(value);
              },
            ),
            const SizedBox(height: 30),

            // 判定ボタン
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => judgmentService.judgeTransaction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  '判定',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // エラーメッセージ表示
            if (judgmentError != null && judgmentError.isNotEmpty)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          judgmentError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 判定結果表示
            if (judgmentResult != null && judgmentResult.isNotEmpty) ...[
              const Text(
                '判定結果',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 8),
              Card(
                color: judgmentResult == "中小受託取引に該当" 
                    ? Colors.green.shade50 
                    : Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            judgmentResult == "中小受託取引に該当" 
                                ? Icons.check_circle 
                                : Icons.warning,
                            color: judgmentResult == "中小受託取引に該当" 
                                ? Colors.green 
                                : Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              judgmentResult,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: judgmentResult == "中小受託取引に該当" 
                                    ? Colors.green.shade700 
                                    : Colors.orange.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        judgmentResult == "中小受託取引に該当"
                            ? "この取引は下請法の適用対象である可能性があります。"
                            : "この取引は下請法の適用対象ではない可能性があります。",
                        style: TextStyle(
                          color: judgmentResult == "中小受託取引に該当" 
                              ? Colors.green.shade600 
                              : Colors.orange.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}