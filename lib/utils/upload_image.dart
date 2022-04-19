import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

typedef ImageID = String;

Future<ImageID?> uploadImage({
  required File file,
  required String userId,
  required String imageId,
}) {
  return FirebaseStorage.instance
      .ref(userId)
      .child(imageId)
      .putFile(file)
      .then<ImageID?>((_) => imageId)
      .catchError((_) => null);
}
