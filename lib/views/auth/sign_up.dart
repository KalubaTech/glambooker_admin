import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/customs/kalubtn.dart';
import 'package:glambooker_admin/customs/kalutext.dart';
import 'package:glambooker_admin/helpers/auth_service.dart';
import 'package:glambooker_admin/helpers/methods.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/auth/sign_in.dart';
import 'package:glambooker_admin/views/auth/sign_up.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  AuthService _authService = AuthService();

  bool _isLoading = false;
  var _isEmailTaken = false.obs;

  Methods _methods = Methods();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() async {
      final emailTaken = await _methods.isEmailTaken(_emailController.text);
          _isEmailTaken.value = emailTaken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/backg.webp'),
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Image.asset('assets/gmbooker_logo.png', width: 100,),
            ),
            SizedBox(height: 40,),
            Container(
                width: double.infinity,
                child: Text('Sign Up!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Karas.primary), textAlign: TextAlign.center,)
            ),
            SizedBox(height: 40,),
            Kalutext(
              controller: _nameController,
              borderRadius: BorderRadius.circular(40),
              hintText: 'Enter Name',
              backgroundColor: Colors.transparent,
              labelText: '    Full Name',
            ),
            const SizedBox(height: 20),
            Kalutext(
              controller: _phoneController,
              borderRadius: BorderRadius.circular(40),
              hintText: 'Enter phone number',
              backgroundColor: Colors.transparent,
              labelText: '    Phone Number',
              isNumber: true,
            ),
            SizedBox(height: 20,),
            Obx(
              ()=> Kalutext(
                controller: _emailController,
                borderRadius: BorderRadius.circular(40),
                hintText: 'Enter Email Address',
                backgroundColor: Colors.transparent,
                labelText: '    Email Address',
                errorText: _isEmailTaken.value ? 'Email is already used!' : null,
              ),
            ),
            SizedBox(height: 20,),
            Kalutext(
              controller: _passwordController,
              borderRadius: BorderRadius.circular(40),
              hintText: 'Enter Password',
              backgroundColor: Colors.transparent,
              labelText: '    Password',
              isObscured: true,
              showEye: true,
            ),
            SizedBox(height: 40,),
            _isLoading
                ? LoadingAnimationWidget.threeArchedCircle(
                color: Karas.action, size: 24)
                : Obx(
                    ()=> Kalubtn(
                          backgroundColor: _isEmailTaken.value?Colors.grey:Karas.primary,
                          label: 'Sign up',
                          onclick: () async {
                            if(!_isEmailTaken.value){
                  setState(() {
                    _isLoading = true;
                  });
                  var _response = await _authService.signUpWithEmailAndPassword(
                    _emailController.text,
                    _passwordController.text,
                    _nameController.text,
                    _phoneController.text,
                  );
                  if (_response == null) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
                                },
                                height: 45,
                                borderRadius: 40,
                              ),
                ),
            SizedBox(height: 30,),
            Container(
              child: Column(
                children: [
                  Kalubtn(
                    width: 140,
                    label: 'Log in',
                    onclick: () {
                      Get.to(() => SignIn(), transition: Transition.fadeIn);
                    },
                    height: 45,
                    borderRadius: 40,
                    backgroundColor: Karas.background,
                    labelStyle: TextStyle(color: Karas.primary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Center(child: Text("Already have an account?")),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
