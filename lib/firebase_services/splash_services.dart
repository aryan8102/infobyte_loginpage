

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajafsg/ui/auth/login_screen.dart';
import 'package:rajafsg/ui/post/post_screen.dart';

class splashservices {

  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3),
              () =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Postscreen()))

      );
    } else {
      Timer(const Duration(seconds: 3),
              () =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))

      );
    }





    }
  }
