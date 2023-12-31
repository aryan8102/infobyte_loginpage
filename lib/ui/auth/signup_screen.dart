
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajafsg/ui/auth/login_screen.dart';
import 'package:rajafsg/utils/utils.dart';
import 'package:rajafsg/widget/round_button.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    void _registerTestUser(String email, String password) async {
      try {
       // UserCredential userCredential = await FirebaseAuth.instance
          _auth
            .createUserWithEmailAndPassword(
            email: email,
            password: password);
        //print(userCredential.user.email);
        setState(() {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    return Scaffold(
      appBar: AppBar(

        title: const Center(child: Text('signup')),
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
                title: 'Sign up',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                   // _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(),

                    // password: passwordcontroller.text.toString(),);
                    _registerTestUser(emailcontroller.text.toString(),passwordcontroller.text.toString());
    //void login();
    }}
            ),
            SizedBox(height: 20,),
            Row(

              children: [
                Text("Already have account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>LoginScreen())
                  );
                },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
