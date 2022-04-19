import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

typedef ImageID = String;

abstract class ImageUploadService {
  Future<ImageID?> uploadImage({
    required String filePath,
    required String userId,
    required String imageId,
  });
}

class FirebaseImageUploadService implements ImageUploadService {
  @override
  Future<ImageID?> uploadImage({
    required String filePath,
    required String userId,
    required String imageId,
  }) {
    final file = File(filePath);
    return FirebaseStorage.instance
        .ref(userId)
        .child(imageId)
        .putFile(file)
        .then<ImageID?>((_) => imageId)
        .catchError((_) => null);
  }
}
