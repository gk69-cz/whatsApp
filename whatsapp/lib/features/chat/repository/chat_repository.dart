import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp/common/models/user_model.dart';


import '../../../common/enum/message_type.dart';
import '../../../common/models/last_message.dart';
import '../../../common/models/message_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void sendFileMessage({
    required var file,
    required BuildContext context,
    required String receiverId,
    required UserModel senderData,
    required Ref ref,
    required MessageType messageType,
  }) async {
    try {
      final timeSent = DateTime.now();
      final messageId = const Uuid().v1();

      
      final userMap = await firestore.collection('user').doc(receiverId).get();
      final receverUserData = UserModel.fromMap(userMap.data()!);

      String lastMessage;

      switch (messageType) {
        case MessageType.image:
          lastMessage = '📸 Photo message';
          break;
        case MessageType.audio:
          lastMessage = '📸 Voice message';
          break;
        case MessageType.video:
          lastMessage = '📸 Video message';
          break;
        case MessageType.gif:
          lastMessage = '📸 GIF message';
          break;
        default:
          lastMessage = '📦 GIF message';
          break;
      }

      saveToMessageCollection(
        receiverId: receiverId,
        textMessage: 'imageUrl',
        timeSent: timeSent,
        textMessageId: messageId,
        senderuserName: senderData.userName,
        receiveruserName: receverUserData.userName,
        messageType: messageType,
      );

      saveAsLastMessage(
        senderUserData: senderData,
        receiverUserData: receverUserData,
        lastMessage: lastMessage,
        timeSent: timeSent,
        receiverId: receiverId,
      );
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<LastMessageModel> contacts = [];
      for (var document in event.docs) {
        final lastMessage = LastMessageModel.fromMap(document.data());
        final userData = await firestore.collection('user').doc(lastMessage.contactId).get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(
          LastMessageModel(
            userName: user.userName,
            profileImageUrl: user.profileImageUrl,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
    required UserModel senderData,
  }) async {
    try {
      final timeSent = DateTime.now();
      final receiverDataMap = await firestore.collection('user').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();

      saveToMessageCollection(
        receiverId: receiverId,
        textMessage: textMessage,
        timeSent: timeSent,
        textMessageId: textMessageId,
        senderuserName: senderData.userName,
        receiveruserName: receiverData.userName,
        messageType: MessageType.text,
      );

      saveAsLastMessage(
        senderUserData: senderData,
        receiverUserData: receiverData,
        lastMessage: textMessage,
        timeSent: timeSent,
        receiverId: receiverId,
      );
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void saveToMessageCollection({
    required String receiverId,
    required String textMessage,
    required DateTime timeSent,
    required String textMessageId,
    required String senderuserName,
    required String receiveruserName,
    required MessageType messageType,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      receiverId: receiverId,
      textMessage: textMessage,
      type: messageType,
      timeSent: timeSent,
      messageId: textMessageId,
      isSeen: false,
    );

    // sender
    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    // receiver
    await firestore
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String lastMessage,
    required DateTime timeSent,
    required String receiverId,
  }) async {
    final receiverLastMessage = LastMessageModel(
      userName: senderUserData.userName,
      profileImageUrl: senderUserData.profileImageUrl,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: lastMessage,
    );

    await firestore
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
      userName: receiverUserData.userName,
      profileImageUrl: receiverUserData.profileImageUrl,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: lastMessage,
    );

    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }
}