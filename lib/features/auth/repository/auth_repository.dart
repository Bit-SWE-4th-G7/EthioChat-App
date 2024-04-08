import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiochat/common/repositories/common_firebase_storage_repository.dart';
import 'package:ethiochat/common/utils/utils.dart';
import 'package:ethiochat/features/auth/screens/otp_screen.dart';
import 'package:ethiochat/features/auth/screens/user_information_screen.dart';
import 'package:ethiochat/models/user_model.dart';
import 'package:ethiochat/screens/mobile_layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

Future<UserModel?> getCurrentUserData() async {
   var userData = await firestore.collection('users').doc(auth.currentUser!.uid).get();
   UserModel? user;
    if(userData.data() != null){
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
  required String name,
  required File? profilePic,
  required ProviderRef ref,
  required BuildContext context,
}) async {
  try {
    String uid = auth.currentUser!.uid;
    String photoURL = 'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

    if (profilePic != null) {
     String storagePath = 'profilePics/$uid/${DateTime.now().millisecondsSinceEpoch}';
     photoURL = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileTOFirebase(
            storagePath, 
            profilePic,
          );
    }
    var user = UserModel(
      name: name,
      uid: uid,
      profilePic: photoURL,
      isOnline: true,
      phoneNumber: auth.currentUser!.uid,
      groupId: [],
    );
    await firestore.collection('users').doc(uid).set(user.toMap());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MobileLayoutScreen(),
      ),
      (route) => false,
    );

  } catch (e) {
    showSnackBar(context: context, content: e.toString());
    }
 }
}
