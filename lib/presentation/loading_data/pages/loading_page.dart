import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/common/riverpod/indiviual_store_info_provider.dart';
import 'package:wcycle_bd_store/common/riverpod/store_order_provider.dart';
import 'package:wcycle_bd_store/presentation/auth/state_managment/user_id_provider.dart';
import 'package:wcycle_bd_store/presentation/main_screen/pages/main_screen.dart';
import 'package:wcycle_bd_store/presentation/product/state_managment/store_data_provider.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(individualStoreProvider.notifier).shopData(context);
    ref.read(userIdProvider.notifier).getUserId();
    ref.watch(storeDataProvider.notifier).shopData();
    ref.watch(storeOrderProvider.notifier).orderData();

    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (!context.mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      },
    );
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
