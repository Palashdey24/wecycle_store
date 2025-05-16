import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class ProfileSections extends StatelessWidget {
  const ProfileSections({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), //or 15.0
        child: Container(
          height: 70.0,
          width: 70.0,
          color: Colors.white,
          child: Image.asset(
            "assets/welcome-stores.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        "Store Name",
        style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
      ),
      subtitle: Text(
        "Under Review",
        style: AppFont.bodySmall(context).copyWith(color: Colors.white70),
      ),
    );
  }
}
