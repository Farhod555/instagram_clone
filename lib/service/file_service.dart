import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/service/auth_service.dart';
import 'log_service.dart';

class FileService {
  static final _storage = FirebaseStorage.instance.ref();
  static final folder_user = 'user_images';

  static Future<String> uploadUserImage(File image) async {

    String uid = AuthService.currentUserId();
    String img_name = uid;
    var firebaseStorageRef = _storage.child(folder_user).child(img_name);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    Log.i(downloadUrl);
    return downloadUrl;
  }
}