import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/presentation/main_screen/pages/main_screen.dart';

import '../common/helper/dialog_loading/dialogs_helper.dart';

class FirebaseApi {
  final firebaseAuth = FirebaseAuth.instance;
  final storageRefs = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;

  User get currentUser => firebaseAuth.currentUser!;

  void setUser(
      Map<String, dynamic> userData, String collection, BuildContext context) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(currentUser.uid)
        .set(userData)
        .whenComplete(
      () {
        if (!context.mounted) return;
        DialogsLoading.removeMessage(context);
        DialogsLoading.showMessage(context, "Sign Up Complete");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          //ModalRoute.withName("/Home")
          (route) => false,
        ).catchError((error) {
          if (!context.mounted) {
            return;
          }
          DialogsLoading.removeMessage(context);
          DialogsLoading.showMessage(
              context, "Account Creation Failed : ${error.message}");

          return;
        });
      },
    );
  }

  Future<String?> uploadFile(
      BuildContext context,
      String folder,
      String typeFolder,
      String fileName,
      File pickfile,
      bool isProgressStop) async {
    final extension = fileName.split(".").last;
    final content = extension == "pdf" ? 'application/pdf' : 'image/$extension';
    final storageReffile =
        storageRefs.ref().child(folder).child(typeFolder).child(fileName);

    UploadTask uploadTask =
        storageReffile.putFile(pickfile, SettableMetadata(contentType: content))
          ..catchError((error) {
            if (!context.mounted) {
              return null;
            }
            DialogsLoading.removeMessage(context);
            DialogsLoading.showMessage(
                context, "Upload file Faild: ${error.message}");
            if (isProgressStop) {
              Navigator.pop(context);
            }

            return null;
          });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //This is can be reusable helper for added data on firebase

  Future<String?> upFirestoreData(Map<String, dynamic> storeData,
      String fsString, BuildContext context) async {
    DialogsLoading.showProgressBar(context);
    final reference = fireStore.collection(fsString);

    final upRecycleData = await reference.add(storeData).then(
      (value) {
        if (context.mounted) {
          Navigator.pop(context);
          DialogsLoading.removeMessage(context);
          DialogsLoading.showMessage(context, "Added Successfully");
          return value.id;
        }
      },
    ).catchError((error) {
      if (!context.mounted) return null;

      Navigator.pop(context);
      DialogsLoading.removeMessage(context);
      DialogsLoading.showMessage(context, "Something Wrong: ${error.message}");
      return null;
    });

    return upRecycleData;
  }
}
