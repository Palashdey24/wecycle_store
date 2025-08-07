import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/riverpod/indiviual_store_info_provider.dart';
import 'package:wcycle_bd_store/presentation/auth/pages/credential_pages.dart';
import 'package:wcycle_bd_store/presentation/auth/state_managment/user_id_provider.dart';
import 'package:wcycle_bd_store/presentation/loading_data/pages/loading_page.dart';
import 'package:wcycle_bd_store/presentation/splash/pages/splash_page.dart';

final fsApis = FirebaseApi();

class AuthStatePages extends ConsumerWidget {
  const AuthStatePages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: fsApis.firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        if (snapshot.hasData) {
          ref.read(userIdProvider);
          ref.read(individualStoreProvider.notifier).shopData(context);
          return const LoadingPage();
        }
        return const CredentialPages();
      },
    );
  }
}
