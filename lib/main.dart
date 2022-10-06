import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/locator.dart';
import 'package:simple/ui/pages/login.dart';
import 'package:simple/ui/pages/sign_up.dart';

void main() {
  setUp();
  runApp(const ProviderScope(child: Simple()));
}

class Simple extends StatefulWidget {
  const Simple({Key? key}) : super(key: key);

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Product-Sans'),
      home: Consumer(builder: (context, ref, _) {
        return ref.watch(toggleAuthPage) ? const SignUp() : const LoginPage();
      }),
    );
  }
}
