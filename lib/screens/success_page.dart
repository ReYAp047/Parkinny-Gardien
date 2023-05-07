import 'package:easy_park_gardien/screens/scan_page.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
      ),
      body: Container(
        child: Center(
          child: Text('La reservation est valide!'),
        ),
      ),
    );
  }
}
