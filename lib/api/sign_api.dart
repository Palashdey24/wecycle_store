import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/presentation/auth/pages/auth_state_page.dart';

final fsApis = FirebaseApi();

class SignApis {
  void signIn(BuildContext context, String emailAddress, String logPass) async {
    final querySnap = await FirebaseFirestore.instance
        .collection("store")
        .where('email', isEqualTo: emailAddress)
        .get();

    if (querySnap.size < 1) {
      if (!context.mounted) return;
      DialogsLoading.removeMessage(context);
      DialogsLoading.showMessage(context, "You credential are not in Store App");
      Navigator.pop(context);
    }

    if (querySnap.size >= 1) {
      try {
        if (!context.mounted) return;

        fsApis.firebaseAuth
            .signInWithEmailAndPassword(email: emailAddress, password: logPass)
            .then(
          (value) {
            if (value.credential?.providerId == null) {
              if (!context.mounted) return;
              Navigator.pop(context);
              return;
            }
            if (!context.mounted) return;
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthStatePages(),
                ));
          },
        ).catchError((e) {
          if (!context.mounted) return;

          Navigator.pop(context);
          DialogsLoading.removeMessage(context);
          if (e.toString() ==
              "type 'List<Object?>' is not a subtype of type 'PigeonUserDetails?' in type cast") {
            return;
          }
          DialogsLoading.showMessage(context, "Issue: $e");
          return;
        });
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) return;
        Navigator.pop(context);
        DialogsLoading.removeMessage(context);
        DialogsLoading.showMessage(context, "Issue: ${error.message}");
        return;
      }
    }
  }
}
