import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/locator.dart';
import 'package:simple/services/transactions_service.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/pages/visuals/chart.dart';
import 'package:simple/ui/utils/colors.dart';

class TransactionHistoryPage extends ConsumerWidget {
  TransactionHistoryPage({Key? key}) : super(key: key);

  final showChart = StateProvider((ref) => true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: AppColor.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColor.black),
        title: regularText(
          'Transaction History',
          fontSize: 20,
          color: AppColor.black,
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () =>
                  ref.read(showChart.notifier).state = !ref.watch(showChart),
              child: regularText(
                ref.watch(showChart) ? 'hide Chart' : 'show Chart',
                color: AppColor.blue,
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          if (ref.watch(showChart))
            const Charts(
              deposit: 30,
              withdrawal: 25,
            ),
          const Flexible(child: TransactionHistory()),
        ],
      ),
    );
  }
}

class TransactionHistory extends ConsumerStatefulWidget {
  final int? tileLength;
  final bool hasAppBar;
  const TransactionHistory({Key? key, this.tileLength, this.hasAppBar = true})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends ConsumerState<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final transationsStream =
        ref.watch(locator.get<TransactionsService>().transactionProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          transationsStream.when(
            loading: () => const Center(
                child: CircularProgressIndicator(strokeWidth: 2.0)),
            data: (data) {
              return Flexible(
                child: ListView.separated(
                  physics: widget.hasAppBar
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var apiData = data.data![index];
                    return CustomTile(
                      type: apiData.type!,
                      title: apiData.phoneNumber.toString(),
                      amount: apiData.amount.toString(),
                      created: apiData.created!,
                    );
                  },
                  itemCount: data.data!
                      .take(widget.tileLength ?? data.data!.length)
                      .length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              );
            },
            error: (error, stackTrace) =>
                Center(child: regularText(error.toString())),
          )
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String amount;
  final String type;
  final String created;
  const CustomTile({
    Key? key,
    required this.title,
    required this.amount,
    required this.type,
    required this.created,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        leading: Container(
          height: 44.0,
          width: 44.0,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: AppColor.blue),
          child: Center(
              child: regularText(title.split('').last,
                  fontSize: 20, color: AppColor.white)),
        ),
        title: regularText(title, fontSize: 20),
        subtitle: regularText(created, fontSize: 12),
        trailing: regularText(
          type == 'credit' ? '+$amount' : '-$amount',
          fontSize: 12.0,
          fontWeight: FontWeight.w800,
          color: type == 'credit' ? AppColor.green : AppColor.red,
        ));
  }
}
