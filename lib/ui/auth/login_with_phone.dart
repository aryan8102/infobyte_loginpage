import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajafsg/ui/auth/verify_code.dart';
import 'package:rajafsg/utils/utils.dart';
import 'package:rajafsg/widget/round_button.dart';
class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+1 234 2382 637 ',
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Login',loading: loading, onTap: (){
              setState(() {
                loading = true;
              });

              auth.verifyPhoneNumber(
                phoneNumber: "+91${phoneNumberController.text.toString()}",
                  verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e){
                  utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId ,int? token){

                  setState(() {
                    loading = false;
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>VerifyCodeScreen(verificartionId:verificationId)));
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                  utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                  });
            })

          ],
        ),
      ),
    );
  }
}
