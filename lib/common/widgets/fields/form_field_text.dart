import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class FormFieldText extends StatelessWidget {
  const FormFieldText(
      {super.key,
      required this.txtInType,
      this.atCorrect,
      this.enSuggest,
      required this.labelTxt,
      required this.hint,
      required this.icons,
      required this.iconCol,
      this.vaildator,
      this.obscure,
      required this.onSave,
      this.maxLen,
      this.intial,
      this.suffixIcons});

  final TextInputType txtInType;
  final bool? atCorrect;
  final bool? enSuggest;
  final String labelTxt;
  final int? maxLen;
  final String hint;
  final IconData icons;
  final bool? suffixIcons;
  final Color iconCol;
  final bool? obscure;
  final String? intial;
  final FormFieldValidator<String>? vaildator;
  final void Function(String value) onSave;

  @override
  Widget build(BuildContext context) {
    bool sIcons = true;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: largeGap),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        autocorrect: atCorrect ?? false,
        initialValue: intial,
        maxLength: maxLen,
        enableSuggestions: enSuggest ?? false,
        keyboardType: txtInType,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.all(15),
          errorBorder: InputBorder.none,
          fillColor: Colors.grey.shade100,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            gapPadding: largeGap,
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          label: Text(
            labelTxt,
            style: AppFont.bodyMedium(context),
          ),
          hintText: hint,
          hintStyle: AppFont.bodySmall(context),
          suffixIcon: suffixIcons != null
              ? IconButton(
                  onPressed: () => sIcons != sIcons,
                  icon: const FaIcon(FontAwesomeIcons.lock),
                  color: iconCol,
                )
              : null,
          prefixIcon: Icon(
            icons,
            color: iconCol,
          ),
        ),
        validator: vaildator,
        style: AppFont.bodyMedium(context),
        onSaved: (newValue) => onSave(newValue!),
      ),
    );
  }
}
