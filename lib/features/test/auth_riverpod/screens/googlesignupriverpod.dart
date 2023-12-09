import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/auth/controller/auth_controller.dart';
import 'package:democrud/features/home/homePage.dart';
import 'package:democrud/features/images/images.dart';
import 'package:democrud/main.dart';
import 'package:democrud/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/auth_controller_riverpod.dart';

class googleSignUpRiverpod extends ConsumerStatefulWidget {
  const googleSignUpRiverpod({super.key});

  @override
  ConsumerState<googleSignUpRiverpod> createState() => _googleSignUpState();
}

class _googleSignUpState extends ConsumerState<googleSignUpRiverpod> {

  void signInWithGoogle(WidgetRef ref,BuildContext context){
    ref.read(riverpodAuthControllerProvider).signInWithGoogle(context);
  }

  // signInWithGoogle() async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   prefs.setBool('login', true);
  //
  //   GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   AuthCredential credential=GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken:googleAuth?.idToken
  //   );
  //
  //
  //
  //
  //   UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
  //   currentuseremail=userCredential.user!.email!;
  //   currentusername=userCredential.user!.displayName!;
  //   currentuserid=userCredential.user!.uid!;
  //   currentuserimage=userCredential.user!.photoURL!;
  //
  //   DocumentSnapshot user=await
  //   FirebaseFirestore.instance.collection('user').doc(currentuserid).get();
  //   if(!user.exists){
  //    final userModel= Modeluser(
  //         email: currentuseremail,
  //         id: currentuserid,
  //         delete: false,
  //         date: DateTime.now(),
  //         name: currentusername,
  //         reference: user.reference);
  //
  //     FirebaseFirestore.instance.collection('user').add(userModel.toJson());
  //   }
  //
  //
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homePage(),), (route) => false);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Sign"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () =>signInWithGoogle(ref,context),
            child: Padding(
              padding: const EdgeInsets.only(left: 150),
              child: Container(
                height: w*0.2,
                width: w*0.2,
                child: Image.asset(Pictures.googleIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
