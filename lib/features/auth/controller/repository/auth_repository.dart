

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/providers/firebase_providers.dart';
import '../../../../main.dart';
import '../../../../model/usermodel.dart';
import '../../../home/homePage.dart';

final authRepositoryProvider =Provider((ref) => AuthRepository(
  firestore: ref.read(firestoreProvider),
  auth: ref.read(authProvider),
  googleSignIn: ref.read(googleSignInProvider),),);

class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
        required FirebaseAuth auth,
        required GoogleSignIn googleSignIn
      }) :  _auth= auth,
        _firestore= firestore,
        _googleSignIn= googleSignIn;

  Future signInWithGoogle(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();



    GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential=GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken:googleAuth?.idToken
    );




    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    currentuseremail=userCredential.user!.email!;
    currentusername=userCredential.user!.displayName!;
    currentuserid=userCredential.user!.uid!;
    currentuserimage=userCredential.user!.photoURL!;

    prefs.setString('loginId', currentuserid);

    DocumentSnapshot user=await
    FirebaseFirestore.instance.collection('user').doc(currentuserid).get();
    if(!user.exists){
      final userModel= Modeluser(
          email: currentuseremail,
          id: currentuserid,
          delete: false,
          date: DateTime.now(),
          name: currentusername,
          reference: user.reference);

      FirebaseFirestore.instance.collection('user').add(userModel.toJson());
    }


    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homePage(),), (route) => false);
  }
}