import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/widgets/page_header.dart';
import 'package:wcycle_bd_store/widgets/page_frame.dart';

class ServicePages extends StatelessWidget {
  const ServicePages({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageFrame(pageWidgets: [
      PageHeader(pageName: "Service"),
    ]);
  }
}
