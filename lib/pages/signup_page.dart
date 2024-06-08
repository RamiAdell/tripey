import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/buttons/Elv_button.dart';
import '../helper/custom_textfiled.dart';
import '../helper/show_snack_bar.dart';
import '../helper/text_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();

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
                height: 110,
              ),
              Center(
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontFamily: "Teachers",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color(0xff052C47),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextfiled(
                obscureText: false,
                controller: _nameController,
                text: 'Name',
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: false,
                  controller: _emailController,
                  text: 'Email'),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: true,
                  controller: _passwordController,
                  text: 'Password'),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: true,
                  controller: _conPasswordController,
                  text: 'Confirm password'),
              SizedBox(
                height: 15,
              ),
              ElvButtons(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});

                    try {
                      await register();
                      showSnackBar(context, 'Successfull');
                      Navigator.pushReplacementNamed(context, 'FirstPage');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context, 'weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'email already exists');
                      }
                    } catch (e) {
                      showSnackBar(context, 'There was an error');
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
                text: 'Signup',
              ),
              SizedBox(
                height: 5,
              ),
              Text_Button(
                text1: 'Already have an account?',
                text2: ' Login',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    addUserDetails(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _conPasswordController.text.trim(),
    );
  }

  Future addUserDetails(String name, String email, String password, String conPassword) async {
    await FirebaseFirestore.instance.collection('users').add({
      'displayName': name,
      'email': email,
      'password': password,
      'conPassword': conPassword,
    });
  }
}
