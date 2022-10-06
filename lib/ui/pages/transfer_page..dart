import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/locator.dart';
// Incase
import 'package:simple/models/transfer_model.dart' as transfer_model;
import 'package:simple/services/accounts_service.dart';
import 'package:simple/services/transactions_service.dart';
import 'package:simple/ui/components/buttons.dart';
import 'package:simple/ui/components/custom_textfield.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/utils/colors.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColor.black),
        elevation: 0,
        title: const Text(
          'Transfer',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: (context) => const Users());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    regularText('Select a beneficiary',
                        fontSize: 20, color: AppColor.blue),
                    const SizedBox(width: 10),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColor.blue),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: accountController,
                title: 'Account Number',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: amountController,
                title: 'Amount',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              buttonWithBorder(
                'Send',
                borderRadius: 15,
                width: 327,
                busy: ref.watch(locator.get<TransactionsService>().loading),
                height: 50,
                textColor: Colors.white,
                onTap: () {
                  if (accountController.text.isEmpty ||
                      amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      // width: double.infinity,
                      content: regularText(
                          'Please fill in account number and amount',
                          color: AppColor.white,
                          textAlign: TextAlign.center),
                      backgroundColor: AppColor.red,
                    ));
                  } else {
                    locator.get<TransactionsService>().sendTransfer(ref, {
                      "phoneNumber": accountController.text,
                      "amount": num.tryParse(amountController.text) ?? 0
                    }).then((transfer_model.TransferModel value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: regularText(value.message!,
                            color: AppColor.white, textAlign: TextAlign.center),
                        backgroundColor: AppColor.green,
                      ));
                      ref.refresh(locator
                          .get<TransactionsService>()
                          .transactionProvider);
                      Navigator.pop(context);
                    }).onError(
                      (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: regularText(error as String,
                              color: AppColor.white,
                              textAlign: TextAlign.center),
                          backgroundColor: const Color(0xFFCA3315),
                        ));
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Users extends ConsumerWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(locator.get<AccountService>().accountsProvider);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20),
        regularText(
          'Beneficiaries',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        regularText(
          'Click account number to copy',
          fontSize: 15,
          color: AppColor.grey,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        accounts.when(
          loading: () => const CircularProgressIndicator(),
          data: (data) => Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: data.data!.length,
                itemBuilder: (context, index) {
                  var accountNumber = data.data![index].phoneNumber!;
                  return CustomTile(
                      phoneNumber: accountNumber,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: accountNumber),
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
                      dateCreated: data.data![index].created!);
                }),
          ),
          error: (error, stackTrace) => regularText(error.toString()),
        )
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  final String phoneNumber;
  final String dateCreated;
  final void Function()? onTap;
  const CustomTile(
      {Key? key,
      required this.phoneNumber,
      required this.dateCreated,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 44.0,
        width: 44.0,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: AppColor.blue),
        child: Center(
            child: regularText(phoneNumber.split('').last,
                fontSize: 20, color: AppColor.white)),
      ),
      title: regularText(phoneNumber, fontSize: 20),
      subtitle: regularText(
        dateCreated,
        fontSize: 12.0,
        color: AppColor.grey,
      ),
    );
  }
}
