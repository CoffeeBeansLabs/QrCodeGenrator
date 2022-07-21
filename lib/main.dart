import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Generator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GenerateQRPage(),
    );
  }
}

class GenerateQRPage extends StatefulWidget {

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 60), (Timer t) =>_fetchPost());

  }

  var _data;

  Future _fetchPost() async  {

    print('print 1');
    http.Response response = await http.get(Uri.parse("https://attendance-application-spring.herokuapp.com/qrcode/save"));
    setState(() {
      _data = jsonDecode(response.body.toString())['uniqueId'];
      print(_data.toString());
    });
    return "Success";
  }


  @override
  Widget build(BuildContext context) {

    Timer.periodic(Duration(minutes: 60), (Timer t) => _fetchPost());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('QR GENERATOR')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: QrImage(
                    // data: controller.text,
                    data:_data.toString(),
                    size: 400,
                    embeddedImage: AssetImage('images/logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(80,80)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
