import 'dart:io';

import 'package:ethiochat/features/auth/repository/auth_repository.dart';
import 'package:ethiochat/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider<UserModel?>((ref) async {
  try {
    final authController = ref.watch(authControllerProvider);
    return await authController.getUserData();
  } catch (e) {
     print('Error fetching user data: $e');
  }
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  Future<UserModel?> getUserData() async {
    try {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  } catch (error) {
    return null;
  }
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      context: context,
      name: name,
      profilePic: profilePic,
      ref: ref,
    );
  }
}
