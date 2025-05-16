import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/widgets/page_header.dart';
import 'package:wcycle_bd_store/widgets/page_frame.dart';

class OrderPages extends StatelessWidget {
  const OrderPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageFrame(pageWidgets: [
      PageHeader(pageName: "Order"),
    ]);
  }
}
