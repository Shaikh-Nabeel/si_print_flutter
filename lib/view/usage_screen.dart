import 'package:flutter/material.dart';
class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Thia is the usage page")
      ],
    );
  }
}
