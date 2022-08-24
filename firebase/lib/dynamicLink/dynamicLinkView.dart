import 'package:flutter/material.dart';

class deepLinkView extends StatefulWidget {
  deepLinkView({Key? key}) : super(key: key);

  @override
  State<deepLinkView> createState() => _deepLinkViewState();
}

class _deepLinkViewState extends State<deepLinkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deep link"),
      ),
    );
  }
}