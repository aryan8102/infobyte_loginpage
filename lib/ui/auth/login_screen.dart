import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajafsg/ui/auth/login_with_phone.dart';
import 'package:rajafsg/ui/auth/signup_screen.dart';
import 'package:rajafsg/ui/post/post_screen.dart';
import 'package:rajafsg/utils/utils.dart';
import 'package:rajafsg/widget/round_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool loading = false ;
  final _formKey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text.toString()).then((value) {
      utils().toastMessage(value.user!.email.toString());
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>Postscreen()));
      setState(() {
        loading = false;
      });
    } ).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Login')),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Form(
                key:_formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      obscureText: true,
                      decoration:const InputDecoration(
                          hintText: 'Email',
                          helperText: 'enter email e.g john@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email)

                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration:const InputDecoration(
                          hintText: 'Password',


                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                )
            ),
      const SizedBox(height: 50,),
              RoundButton(
                  title: 'Login',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                }
      ),
              SizedBox(height: 20,),
              Row(

                children: [
                  Text("Don't have account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>SignupScreen())
                    );
                  },
                      child: Text('Sign up'))
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));

                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Center(
                    child: Text('Login with phone'),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
