import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/customs/kalutext.dart';
import 'package:glambooker_admin/helpers/auth_service.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/auth/forgot_password.dart';
import 'package:glambooker_admin/views/auth/sign_up.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../utils/colors.dart';

import '../home/dashboard.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/backg.webp'),
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Image.asset('assets/gmbooker_logo.png', width: 100),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'WELCOME!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Karas.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Kalutext(
              controller: _emailController,
              borderRadius: BorderRadius.circular(40),
              hintText: 'Enter Email',
              backgroundColor: Colors.transparent,
              labelText: '    Email Address',
            ),
            const SizedBox(height: 20),
            Kalutext(
              controller: _passwordController,
              borderRadius: BorderRadius.circular(40),
              hintText: 'Enter Password',
              backgroundColor: Colors.transparent,
              labelText: '    Password',
              isObscured: true,
              showEye: true,
            ),
            const SizedBox(height: 40),
            _isLoading
                ? LoadingAnimationWidget.threeArchedCircle(
                color: Karas.action, size: 24)
                : Kalubtn(
              label: 'Log in',
              onclick: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  var response = await _authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                  if(response==null){
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              height: 45,
              borderRadius: 40,
            ),
            TextButton(
              onPressed: () {
                Get.to(()=>ForgotPassword(), transition: Transition.fadeIn);
              },
              child: const Text('Forgot password'),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Kalubtn(
                  width: 140,
                  label: 'Create',
                  onclick: () {
                    Get.to(() => SignUp(), transition: Transition.fadeIn);
                  },
                  height: 45,
                  borderRadius: 40,
                  backgroundColor: Karas.background,
                  labelStyle: TextStyle(color: Karas.primary),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text("Don't have an account?"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
