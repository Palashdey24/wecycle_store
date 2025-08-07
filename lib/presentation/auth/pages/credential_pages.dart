import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/presentation/auth/widgets/credential/credential_frame.dart';

class CredentialPages extends StatelessWidget {
  const CredentialPages({super.key});

  @override
  Widget build(BuildContext context) {
    final heights = PhoneSize.deviceHeight(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: heights,
            child: const CredentialFrame(),
          ),
        ],
      ),
    );
  }
}
