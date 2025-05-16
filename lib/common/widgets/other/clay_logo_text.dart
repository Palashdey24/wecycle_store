import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd_store/core/config/utility/string/app_string.dart';

class ClayLogoText extends StatelessWidget {
  const ClayLogoText({super.key, this.clayTColor});

  final Color? clayTColor;

  @override
  Widget build(BuildContext context) {
    return ClayText(
      AppString.kAppName.toUpperCase(),
      emboss: true,
      color: clayTColor ?? Theme.of(context).scaffoldBackgroundColor,
      size: 35,
      style: GoogleFonts.baskervville(),
    );
  }
}
