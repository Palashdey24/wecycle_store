import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/common/riverpod/indiviual_store_info_provider.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class ProfileSections extends ConsumerWidget {
  const ProfileSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(individualStoreProvider.notifier).shopData(context);
    final storeData = ref.watch(individualStoreProvider);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), //or 15.0
        child: Container(
          height: 70.0,
          width: 70.0,
          color: Colors.white,
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage("assets/welcome-stores.png"),
            image: NetworkImage(
              storeData.logoUri,
            ),
          ),
        ),
      ),
      title: Text(
        storeData.storeName,
        style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
      ),
      subtitle: Text(
        storeData.storeStatus,
        style: AppFont.bodySmall(context).copyWith(color: Colors.white70),
      ),
    );
  }
}
