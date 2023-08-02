import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajafsg/ui/auth/login_screen.dart';
import 'package:rajafsg/utils/utils.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('postscreen'),
        actions: [
         IconButton(onPressed: (){
           auth.signOut().then((value){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    }).onError((error, stackTrace) {
      utils().toastMessage(error.toString());
           });
         },
           icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 20,),



        ],
      ),
    );
  }
}
