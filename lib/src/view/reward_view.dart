
import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blapp/src/view/home_view.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardState createState() => new _RewardState();
}

class _RewardState extends State<RewardScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
                  leading: new IconButton(icon: new Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState.openDrawer()),
                 title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pontuação e Recompensas",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              '(0 disponíveis / 0 resgatados)',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )
          ],
        ),
          actions: <Widget>[new Padding(padding:const EdgeInsets.all(13.0), child:Icon(Icons.history))],
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.pink,
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    onPressed: scan,
                    child: const Text('Resgatar')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode as String);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'O usuário não concedeu permissão para utilizar a câmera.';
        });
      } else {
        setState(() => this.barcode = 'Erro: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'O usuário cancelou a leitura do QRCode.');
    } catch (e) {
      setState(() => this.barcode = 'Erro: $e');
    }
  }
}