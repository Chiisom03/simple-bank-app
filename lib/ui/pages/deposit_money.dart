import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/ui/components/buttons.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/utils/colors.dart';

class DepositMoneyPage extends ConsumerStatefulWidget {
  const DepositMoneyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DepositMoneyPageState();
}

class _DepositMoneyPageState extends ConsumerState<DepositMoneyPage> {
  @override
  Widget build(BuildContext context) {
    const accountNumber = '23333555555';
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColor.black),
        elevation: 0,
        title: const Text(
          'Deposit',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                regularText(
                    'Copy your account number and make transfer to it to deposit money in your account',
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    color: AppColor.grey,
                    fontWeight: FontWeight.w700),
                const SizedBox(height: 20),
                regularText(accountNumber,
                    fontSize: 30, fontWeight: FontWeight.w700),
                const SizedBox(height: 32),
                buttonWithBorder(
                  'copy',
                  borderRadius: 15,
                  width: 327,
                  height: 50,
                  textColor: Colors.white,
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(text: accountNumber),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        width: 200,
                        backgroundColor: AppColor.green,
                        behavior: SnackBarBehavior.floating,
                        dismissDirection: DismissDirection.horizontal,
                        content: regularText(
                          'account number copied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
