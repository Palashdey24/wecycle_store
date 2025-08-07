import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProviderNotifier extends StateNotifier<String> {
  UserProviderNotifier() : super("");

  Future<void> getUserId() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    state = userId;
  }
}

final userIdProvider = StateNotifierProvider<UserProviderNotifier, String>(
  (ref) => UserProviderNotifier(),
);
