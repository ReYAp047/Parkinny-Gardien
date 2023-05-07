import 'package:easy_park_gardien/screens/scan_page.dart';
import 'package:flutter/material.dart';

class FailPage extends StatelessWidget {
  const FailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 300),
        child: Column(
          children: [
            Center(
              child: Text('Reservation invalide !'),
            ),
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Validation de l'Action sabot"),
                          content: Text("Si vous valider, Une notification a été envoyée au propriétaire du véhicule "),
                          actions: [
                            ElevatedButton(
                              child: Text("Valider"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Sabot'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Validation de l'Action Chonguelle."),
                          content: Text("Si vous valider, Une notification a été envoyée au propriétaire du véhicule "),
                          actions: [
                            ElevatedButton(
                              child: Text("Valider"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Chonguelle'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
