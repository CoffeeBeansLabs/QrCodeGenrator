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
      title: 'Qr Generator App',
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

  }

  var _data;

  Future _fetchPost() async  {


    print('print 1');
    http.Response response = await http.get(Uri.parse("https://attendance-application-spring.herokuapp.com/qrcode/uniqueId"));
    setState(() {
      _data = jsonEncode(response.body.toString());
      print(_data.toString());
    });
  }


  @override
  Widget build(BuildContext context) {

    _fetchPost();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          
          child: Center(
            child: Center(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset('assets/shelf2.png',height: 140,)),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(40),
                      child: Container(
                        margin: EdgeInsets.only(top: 110),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
