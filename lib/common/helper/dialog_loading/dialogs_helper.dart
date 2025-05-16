import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/common/widgets/loading/loading_widget.dart';

class DialogsLoading {
  static void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }

 static void removeMessage(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

 static void showProgressBar(BuildContext context, {String? waitingMsg}) {
    showDialog(
      context: context,
      builder: (_) {
        return Center(
            child: LoadingWidgets(
          backgroundColor: Colors.transparent,
          waitingMessage: waitingMsg,
        ));
      },
    );
  }
}
