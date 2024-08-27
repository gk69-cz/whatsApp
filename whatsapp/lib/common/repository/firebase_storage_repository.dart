import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseStorageRepositoryProvide = 
Provider((ref) => FirebaseStorageRepository(
  firebaseStorage: FirebaseStorage.instance),);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

FirebaseStorageRepository({required this.firebaseStorage});

storeFiletoFirebase(String ref, var file)async {
  UploadTask? uploadTask;
  if(file is File) {
    uploadTask = firebaseStorage.ref(ref).putFile(file);
  }
  if(file is Uint8List){
    uploadTask = firebaseStorage.ref(ref).putData(file);
  }

  TaskSnapshot snapshot = await uploadTask!;
  String imageUrl = await snapshot.ref.getDownloadURL();
  return imageUrl;

}

}