import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/locator.dart';
import 'package:simple/models/auth_model.dart' as auth_model;
import 'package:simple/services/accounts_service.dart';
import 'package:simple/ui/components/buttons.dart';
import 'package:simple/ui/components/custom_textfield.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/pages/homepage.dart';
import 'package:simple/ui/pages/sign_up.dart';
import 'package:simple/ui/utils/colors.dart';
import 'package:simple/ui/utils/utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final isObscureText = StateProvider((ref) => true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            regularText(
              'Login',
              fontSize: 30.0,
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            regularText(
              'welcome back, please fill in your details to login',
              fontSize: 16.0,
              color: AppColor.grey,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
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
              title: 'password',
              textInputAction: TextInputAction.done,
              controller: passwordController,
              obscureText: ref.watch(isObscureText),
              suffixIcon: GestureDetector(
                onTap: () {
                  ref.read(isObscureText.notifier).state =
                      !ref.read(isObscureText);
                },
                child: Icon(
                  ref.watch(isObscureText)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            const SizedBox(height: 32),
            buttonWithBorder(
              'Login',
              borderRadius: 15,
              width: 327,
              height: 50,
              textColor: Colors.white,
              busy: ref.watch(locator.get<AccountService>().isLogging),
              onTap: () {
                if ((phoneNumberController.text.isEmpty) ||
                    (passwordController.text.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: regularText('please fill in empty fields',
                        color: AppColor.white, textAlign: TextAlign.center),
                    backgroundColor: AppColor.red,
                  ));
                } else {
                  locator.get<AccountService>().login(ref, {
                    "phoneNumber": phoneNumberController.text.trim(),
                    "amount": passwordController.text.trim()
                  }).then((auth_model.AuthModel value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: regularText(
                        value.message!,
                        color: AppColor.white,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: AppColor.green,
                    ));
                    pushReplacement(context, const HomePage());
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
            const SizedBox(height: 25),
            Text.rich(TextSpan(
              text: 'Don\'t have an account? ',
              children: [
                WidgetSpan(
                  child: GestureDetector(
                      onTap: () => ref.read(toggleAuthPage.notifier).state =
                          !ref.watch(toggleAuthPage),
                      child: regularText(
                        'Sign up',
                        color: AppColor.blue,
                        fontWeight: FontWeight.w700,
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
