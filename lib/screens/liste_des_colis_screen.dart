import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class ListeDesColisScreen extends StatefulWidget {
  @override
  _ListeDesColisScreenState createState() => _ListeDesColisScreenState();
}

class _ListeDesColisScreenState extends State<ListeDesColisScreen> {
  String dropdownValue = 'expedie';

  String? qrCodeText;
  final QrBarCodeScannerDialog qrBarCodeScannerDialog = QrBarCodeScannerDialog();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Colis'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/colis.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text('${index + 1}'),
                title: ElevatedButton(
                  onPressed: () {

                    qrBarCodeScannerDialog.getScannedQrBarCode(context:context,onCode: (code){setState(() {
                      qrCodeText=code;
                    });

                    print(' \n\n\n\n\n');
                      print(code);});

                  },
                  child: Text('Scanner'),
                ),
                trailing: DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['expedie', 'retourné'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// Win l button?