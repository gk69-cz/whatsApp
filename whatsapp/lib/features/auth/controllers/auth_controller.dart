import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(AuthRepositoryProvider);
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});
    Stream<UserModel> getUserPresenceStatus({required String uid}){
      return authRepository.getUserPresenceStatus(uid: uid);
    }
  
  void updateUserPresence() async {
    return authRepository.updateUserPresence();
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void saveUserInfoToFirestore(
      {required String username,
      required var profileImage,
      required BuildContext context,
      required bool mounted}) async {
    authRepository.saveUserInfoToFirestore(
      username: username,
      profileImage: profileImage,
      ref: ref,
      context: context,
      mounted: mounted,
    );
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    authRepository.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) {
    authRepository.sendSmsCode(context: context, phoneNumber: phoneNumber);
  }
}
