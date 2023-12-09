

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/core/providers/riverpod_firebase_providers.dart';
import 'package:democrud/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../model/riverpod_modeluser.dart';
import '../screens/googlesignupriverpod.dart';
import '../screens/homePageRiverpod.dart';



 final authRepositoryProvider1 = Provider((ref) => RiverpodAuthRepository(
   firestore: ref.read(firestoreProvider1),
   auth: ref.read(authProvider1),
   googleSignIn: ref.read(googleSignInProvider1),

 ));

class RiverpodAuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  RiverpodAuthRepository(
  {required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  }
      ):_auth =auth,
        _firestore=firestore,
        _googleSignIn=googleSignIn;


  Future signInWithGoogle(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();



    GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential=GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken:googleAuth?.idToken
    );




    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    riverpodCurrentUserEmail=userCredential.user!.email!;
    riverpodCurrentUserName=userCredential.user!.displayName!;
    riverpodCurrentUserId=userCredential.user!.uid!;
    riverpodCurrentUserImage=userCredential.user!.photoURL!;

    prefs.setString('loginidriverpod', riverpodCurrentUserId);

    DocumentSnapshot user=await
    FirebaseFirestore.instance.collection('Riverpoduser').doc(riverpodCurrentUserId).get();
    if(!user.exists){
      final RiverpoduserModel= RiverpodModelUser(
          name:riverpodCurrentUserName,
          email: riverpodCurrentUserEmail,
          id: riverpodCurrentUserId,
          delete: false,
          reference: user.reference

      );

      FirebaseFirestore.instance.collection('Riverpoduser').add(RiverpoduserModel.toJson());
    }


    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homePageRiverpod(),), (route) => false);
  }


  signOutRiverpod(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginidriverpod');
    await GoogleSignIn().signOut().then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => googleSignUpRiverpod()), (route) => false);
    });
  }

}