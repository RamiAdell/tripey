import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/helper/custom_textfiled.dart';
import 'package:my_app/helper/text_button.dart';
import 'package:my_app/pages/firstpage.dart';

import '../helper/show_snack_bar.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f1),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset("assets/xyz.png"),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: "Teachers",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color(0xff052C47),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              CustomTextfiled(
                  obscureText: false,
                  controller: emailController,
                  text: 'Email'),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: true,
                  controller: passwordController,
                  text: 'Password'),
              SizedBox(
                height: 15,
              ),
              ElvButtons(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(
                      () {},
                    );

                    try {
                      
                      await login();
                      showSnackBar(context, 'Successful');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FirstPage();
                      }));
                      emailController.clear();
                      passwordController.clear();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'user not found');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context, 'wrong password');
                      }
                    } catch (e) {
                      showSnackBar(context, 'There was an error');
                    }
                    isLoading = false;
                    setState(
                      () {},
                    );
                  }
                },
                text: 'Login',
              ),
              SizedBox(
                height: 5,
              ),
              Text_Button(
                text1: 'Don\'t have an account?',
                text2: ' Signup',
                onTap: () {
                  Navigator.pushNamed(context, 'SignupPage');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
  }
}
