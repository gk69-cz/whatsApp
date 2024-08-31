import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/models/user_model.dart';

final ContactRepositoryProvider = Provider((ref) {
  return ContactRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ContactRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ContactRepository({required this.firestore, required this.auth});


  Future<List<List<UserModel>>> getAllContact() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts =
        []; // Corrected from `phoneNumber` to `phoneContacts`

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('user').get();
        final allContactsOnPhone =
            await FlutterContacts.getContacts(withProperties: true);
        for (var contact in allContactsOnPhone) {
          bool isContactFound = false;
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());

            if (contact.phones.isNotEmpty) {
             
              if (contact.phones[0].number.replaceAll(' ', '') ==
                  firebaseContact.phoneNumber.replaceAll(' ', '')) {
              firebaseContacts.add(firebaseContact);
                isContactFound = true;
                break;
              }
            }
          }
          if (contact.phones.isNotEmpty) {
            if (!isContactFound) {
              phoneContacts.add(
                UserModel(
                  userName: contact
                      .displayName, // Assuming contact.name is displayName
                  uid: '',
                  profileImageUrl: '',
                  active: false,
                  phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
                  groupId: [], lastScene: 0,
                ),
              );
            }
          }
          isContactFound = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return [firebaseContacts, phoneContacts]; // Return the corrected list
  }
}
