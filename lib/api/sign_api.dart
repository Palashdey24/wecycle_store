import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/presentation/loading_data/pages/loading_page.dart';

final fsApis = FirebaseApi();

class SignApis {
  static void signIn(
      BuildContext context, String emailAddress, String logPass) async {
    final accountValid = await checkAccountValid(emailAddress, context);

    if (accountValid) {
      try {
        fsApis.firebaseAuth
            .signInWithEmailAndPassword(email: emailAddress, password: logPass)
            .whenComplete(
          () {
            if (!context.mounted) return;
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pop(context);
              DialogsLoading.removeMessage(context);
              DialogsLoading.showMessage(
                  context, "Issue: User Not Found or Credential wrong");
              return;
            }

            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingPage(),
                ));
          },
        );
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) return;
        Navigator.pop(context);
        DialogsLoading.removeMessage(context);
        DialogsLoading.showMessage(context, "Issue: ${error.message}");
        return;
      }
    }
  }

  static Future<bool> checkAccountValid(
      String emailAddress, BuildContext context) async {
    final querySnap = await FirebaseFirestore.instance
        .collection("store")
        .where('email', isEqualTo: emailAddress)
        .get();

    if (querySnap.size < 1) {
      if (!context.mounted) return false;
      DialogsLoading.removeMessage(context);
      DialogsLoading.showMessage(
          context, "You credential are not in Store App");
      Navigator.pop(context);
      return false;
    } else if (querySnap.size >= 1) {
      return true;
    }

    return false;
  }
}
