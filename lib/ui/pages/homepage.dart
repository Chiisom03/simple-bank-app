import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/pages/deposit_money.dart';
import 'package:simple/ui/pages/transaction_history.dart';
import 'package:simple/ui/pages/transfer_page..dart';
import 'package:simple/ui/pages/widthdrawal.dart';
import 'package:simple/ui/utils/colors.dart';
import 'package:simple/ui/utils/utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

final hideBalance = StateProvider((ref) => false);

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
            backgroundColor: AppColor.white,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            elevation: 0,
            title: regularText(
              'Hello, 23333555555',
              fontSize: 19.0,
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              InkWell(
                onTap: () => push(context, const DepositMoneyPage()),
                borderRadius: BorderRadius.circular(100),
                child: Center(
                  child: regularText(
                    'Add Money',
                    color: AppColor.black,
                  ),
                ),
              ),
              const SizedBox(width: 30)
            ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
            child: Column(
              children: [
                const CreditCard(),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    regularText(
                      'Recent Transactions',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                    GestureDetector(
                      onTap: () => push(context, TransactionHistoryPage()),
                      child: regularText(
                        'view all',
                        fontSize: 16.0,
                        color: AppColor.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(
                    height: 350,
                    child: TransactionHistory(
                      tileLength: 5,
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkBlue,
          child: const Icon(Icons.send_outlined),
          onPressed: () {
            push(context, const TransferPage());
          },
        ),
      ),
    );
  }
}

class CreditCard extends ConsumerWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController amountController = TextEditingController();

    return Container(
      height: 216,
      width: 360,
      decoration: BoxDecoration(
        color: AppColor.darkBlue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 30,
                    child: regularText(
                      'Account Balance',
                      fontSize: 17.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w600,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    regularText(
                      ref.watch(hideBalance) ? '******' : '\$6,625.50',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(hideBalance.notifier).state =
                            !ref.read(hideBalance);
                      },
                      child: Icon(
                        ref.watch(hideBalance)
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 22.0,
              bottom: 32.0,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText(
                      'Account Number',
                      fontSize: 17.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: regularText(
                              '3409 *** *** 7238',
                              fontSize: 16.0,
                              color: AppColor.white,
                            )),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    push(context, const WithdrawalPage());
                  },
                  child: regularText('withdraw',
                      color: AppColor.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
