import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

import 'package:wcycle_bd_store/core/config/theme/gap.dart';

final fontHelpers = AppFont();

class FieldTexts extends StatefulWidget {
  const FieldTexts({
    super.key,
    required this.txtInType,
    this.atCorrect,
    this.enSuggest,
    required this.hint,
    required this.icons,
    required this.iconCol,
    this.obscure,
    this.maxLen,
    required this.fieldFn,
    this.backgroundColor,
    this.paddingVertical,
    this.paddingHorizential,
  });

  final TextInputType txtInType;
  final void Function(String fieldValue) fieldFn;
  final bool? atCorrect;
  final bool? enSuggest;
  final int? maxLen;
  final String hint;
  final IconData icons;
  final Color iconCol;
  final bool? obscure;
  final Color? backgroundColor;
  final double? paddingVertical;
  final double? paddingHorizential;

  @override
  State<FieldTexts> createState() => _FieldTextsState();
}

class _FieldTextsState extends State<FieldTexts> {
  late TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.paddingVertical ?? 0,
          horizontal: widget.paddingHorizential ?? 0),
      child: TextField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        autocorrect: widget.atCorrect ?? false,
        controller: _textController,
        onChanged: (value) => widget.fieldFn(value),
        maxLength: widget.maxLen,
        enableSuggestions: widget.enSuggest ?? false,
        keyboardType: widget.txtInType,
        obscureText: widget.obscure ?? false,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.all(15),
          errorBorder: InputBorder.none,
          fillColor: widget.backgroundColor,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.horizontal(left: Radius.elliptical(10, 10)),
            borderSide: BorderSide(color: Colors.orange, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius:
                BorderRadius.horizontal(left: Radius.elliptical(10, 10)),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          hintText: widget.hint,
          prefixIcon: ClipRRect(
            child: Container(
              margin: const EdgeInsets.only(right: normalGap),
              // padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.elliptical(10, 10)),
                  color: Colors.white),
              child: Icon(
                widget.icons,
                color: widget.iconCol,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
