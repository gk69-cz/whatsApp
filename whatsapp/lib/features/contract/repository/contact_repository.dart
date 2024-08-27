import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/models/user_model.dart';

final ContactRepositoryProvider = Provider((ref) {
  return ContactRepository(firestore: FirebaseFirestore.instance);
});

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({required this.firestore});

  Future<List<List<UserModel>>> getAllContact() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = []; // Corrected from `phoneNumber` to `phoneContacts`
 
    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('user').get();
        final allContactsOnPhone =
            await FlutterContacts.getContacts(withProperties: true);
        for (var contact in allContactsOnPhone) {
          bool isContactFound = false;
         for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            if (contact.phones.length != 0 ){
            if (contact.phones[0].number.replaceAll(' ', '') ==
                firebaseContact.phoneNumber) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }}
          if (contact.phones.length != 0 ){
          if (!isContactFound) {
            print('here ??');
            phoneContacts.add(
              UserModel(
                username:contact.displayName, // Assuming contact.name is displayName
                uid: '',
                
                profileImageUrl: '',
                active: false,
                phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
                groupId: [], lastScene: 0,
              ),
            );
          }}
          isContactFound = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return [firebaseContacts, phoneContacts]; // Return the corrected list
  }
}
