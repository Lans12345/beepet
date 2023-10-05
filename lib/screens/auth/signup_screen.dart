import 'package:beepet/screens/auth/login_screen.dart';
import 'package:beepet/screens/auth/otp_screen.dart';
import 'package:beepet/services/add_user.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:beepet/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SignupScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  SignupScreen({super.key});

  final box = GetStorage();

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
          child: SingleChildScrollView(
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
                  child: TextFieldWidget(
                      isObscure: true,
                      label: 'Password',
                      controller: passwordController),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: TextFieldWidget(
                        label: 'Phone Number', controller: phoneController)),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: TextFieldWidget(
                        label: 'Address', controller: addressController)),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: ButtonWidget(
                        radius: 100,
                        color: Colors.teal[600]!.withOpacity(0.5),
                        label: 'Signup',
                        onPressed: () {
                          box.write('username', usernameController.text);
                          box.write('password', passwordController.text);
                          box.write('contactNumber', phoneController.text);
                          addUser(usernameController.text, phoneController.text,
                              addressController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OTPScreen()));
                        })),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextRegular(
                        text: 'Already had an account?',
                        fontSize: 12,
                        color: Colors.grey),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: TextBold(
                          text: 'Login', fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
