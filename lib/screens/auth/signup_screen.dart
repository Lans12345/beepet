import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:beepet/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 180,
              ),
              TextBold(
                  text: 'Welcome to\n BeePet!',
                  fontSize: 36,
                  color: Colors.grey),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: TextFieldWidget(
                      label: 'Username', controller: usernameController)),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldWidget(
                      label: 'Password', controller: passwordController),
                  TextButton(
                    onPressed: () {},
                    child: TextBold(
                        text: 'Forgot Password?',
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ],
              )),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: ButtonWidget(
                      radius: 100,
                      color: solid,
                      label: 'Login',
                      onPressed: () {})),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
