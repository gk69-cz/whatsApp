import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp/common/helpers/show_loading.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/repository/firebase_storage_repository.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';

final AuthRepositoryProvider = Provider((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      realtime: FirebaseDatabase.instance);
});

final userInfoAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserInfo();
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtime;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.realtime,
  });

  Stream<UserModel> getUserPresenceStatus({required String uid}){
    return firestore.
    collection('user').
    doc(uid).
    snapshots().
    map((event) => UserModel.fromMap(event.data()!));
  }

  void updateUserPresence() async {
    Map<String, dynamic> online = {
      'active': true,
      'lastScene': DateTime.now().millisecondsSinceEpoch,
    };
    Map<String, dynamic> offline = {
      'active': false,
      'lastScene': DateTime.now().millisecondsSinceEpoch,
    };
    final connectedRef = realtime.ref('.info/connected');
    connectedRef.onValue.listen((event) async {
      final isConnected = event.snapshot.value as bool? ?? false;
      if (isConnected) {
        await realtime.ref().child(auth.currentUser!.uid).update(online);
      } else {
        realtime
            .ref()
            .child(auth.currentUser!.uid)
            .onDisconnect()
            .update(online);
      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await firestore.collection('user').doc(auth.currentUser?.uid).get();
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFirestore(
      {required String userName,
      required var profileImage,
      required ProviderRef ref,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context: context, message: 'Saving the user info... ');
      String uid = auth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : '';
      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(FirebaseStorageRepositoryProvide)
            .storeFiletoFirebase('profileImage/$uid', profileImage);
      }
      UserModel user = UserModel(
          userName: userName,
          uid: uid,
          profileImageUrl: profileImageUrl,
          active: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [],
          lastScene: DateTime.now().millisecondsSinceEpoch);

      await firestore.collection('user').doc(uid).set(user.toMap());
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: 'Verifing the code');

      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.userInfo, (route) => false,
          arguments: user?.profileImageUrl);
    } on FirebaseAuth catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      showLoadingDialog(
          context: context,
          message: 'Sending the verification code to $phoneNumber');
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialog(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendSmsCodeId) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.verification, (route) => false, arguments: {
              'phoneNumber': phoneNumber,
              'smsCodeId': smsCodeId
            });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
