import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/common/models/user_model.dart';

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({required this.firestore});

  Future<List<List<UserModel>>> getAllContact() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];  // Corrected from `phoneNumber` to `phoneContacts`

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allContactsOnPhone =
            await FlutterContacts.getContacts(withProperties: true);
        
        for (var contact in allContactsOnPhone) {
          bool isContactFound = false;
          if (contact.phones.isNotEmpty) { // Ensure there is at least one phone number
            String phoneNumber = contact.phones[0].number.replaceAll(' ', '');
            for (var firebaseContactData in userCollection.docs) {
              var firebaseContact =
                  UserModel.fromMap(firebaseContactData.data());
              if (phoneNumber == firebaseContact.phoneNumber) {
                firebaseContacts.add(firebaseContact);
                isContactFound = true;
                break;
              }
            }
            if (!isContactFound) {
              phoneContacts.add(
                UserModel(
                  username: contact.displayName, // Assuming contact.name is displayName
                  uid: '',
                  profileImageUrl: '',
                  active: false,
                  phoneNumber: phoneNumber,
                  groupId: [],
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return [firebaseContacts, phoneContacts];  // Return the corrected list
  }
}
