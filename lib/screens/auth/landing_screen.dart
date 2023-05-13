import 'package:beepet/screens/auth/login_screen.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back1.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Center(
                child: Image.asset('assets/images/logo.png', height: 300),
              ),
              const SizedBox(
                height: 180,
              ),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Center(
                  child: TextBold(
                      text: 'Tap anywhere to continue',
                      fontSize: 18,
                      color: primary),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
