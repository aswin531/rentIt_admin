// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        print("Failed to get GoogleSignInAccount or authentication");
        return null;
      }
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print("auth token : ${googleAuth.accessToken}");
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error in Google SIgnIn : $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await firestore.collection("admin").doc(user.uid).set({
          'email': email,
          'name': name,
          'phone': phone,
          'uid': user.uid,
        });
      }
      print(user);
      return user;
    } catch (e) {
      print('Failed to sign up : $e');
      return null;
    }
  }

  //sign In

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Failed to Sign In : $e');
      return null;
    }
  }

  //signOut

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print("Failed to sign out : $e");
    }
  }

  //
  User? get currentUser => firebaseAuth.currentUser;
}