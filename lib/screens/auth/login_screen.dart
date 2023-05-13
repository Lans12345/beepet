import 'package:beepet/screens/auth/signup_screen.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:beepet/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 125,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextBold(text: 'or', fontSize: 14, color: Colors.grey),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 125,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: ButtonWidget(
                      radius: 100,
                      color: secondarySolid.withOpacity(0.5),
                      label: 'Signup',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
