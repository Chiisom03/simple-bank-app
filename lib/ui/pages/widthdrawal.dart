import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/locator.dart';
import 'package:simple/models/auth_model.dart' as auth_model;
import 'package:simple/services/transactions_service.dart';
import 'package:simple/ui/components/buttons.dart';
import 'package:simple/ui/components/custom_textfield.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/utils/colors.dart';

class WithdrawalPage extends ConsumerStatefulWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends ConsumerState<WithdrawalPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.black),
        backgroundColor: AppColor.white,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            regularText(
              'Withdraw funds',
              fontSize: 30.0,
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              title: 'Account Number',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: phoneNumberController,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              title: 'amount',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: amountController,
            ),
            const SizedBox(height: 32),
            buttonWithBorder(
              'Withdraw',
              borderRadius: 15,
              width: 327,
              height: 50,
              textColor: Colors.white,
              busy: ref.watch(locator.get<TransactionsService>().isWithdrawing),
              onTap: () {
                if ((phoneNumberController.text.isEmpty) ||
                    (amountController.text.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: regularText('please fill in empty fields',
                        color: AppColor.white, textAlign: TextAlign.center),
                    backgroundColor: AppColor.red,
                  ));
                } else {
                  locator.get<TransactionsService>().withdrawal(ref, {
                    "phoneNumber": phoneNumberController.text.trim(),
                    "amount": num.tryParse(amountController.text) ?? 0
                  }).then((auth_model.AuthModel value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: regularText(
                        value.message!,
                        color: AppColor.white,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: AppColor.green,
                    ));
                  }).onError(
                    (error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: regularText(error as String,
                            color: AppColor.white, textAlign: TextAlign.center),
                        backgroundColor: AppColor.red,
                      ));
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
