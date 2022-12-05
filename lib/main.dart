import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screen_wake/flutter_screen_wake.dart';

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
  bool isloading=false;
  @override
  void initState()  {
    super.initState();

  }
  Future CallWakeup() async {
    double brightness = await FlutterScreenWake.brightness;

// Set the brightness:
    FlutterScreenWake.setBrightness(0.5);

// Check if the screen is kept on:
    bool isKeptOn = await FlutterScreenWake.isKeptOn;

// Prevent screen from going into sleep mode:
    FlutterScreenWake.keepOn(true);
  }

  var _data;

  Future _fetchPost() async  {
    isloading=true;

    try{

      print('print 1');
      http.Response response = await http.get(Uri.parse("https://qa-cbattendancebe.coffeebeans.io/qrcode/uniqueId"));
      setState(() {
        _data = jsonEncode(response.body.toString());
        print(_data.toString());
      });
    }
    catch(error) {
      print("Unexpected error");
      print(error);
      _fetchPost();
    }
    }

  @override
  Widget build(BuildContext context) {

    Timer(Duration(milliseconds: 3000),_fetchPost);
    Timer(Duration(seconds: 0),CallWakeup);
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset('assets/shelf2.png',height: 140,)
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                      child: Text("Please visit espresso.coffeebeans.io\nfor marking your attendance.",
                        style: TextStyle(color:Colors.brown[400],fontSize: 18,fontWeight: FontWeight.w700),)
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.all(35),
                      child: Container(
                        child:isloading ?  QrImage(
                          data:_data.toString(),
                          embeddedImageStyle: QrEmbeddedImageStyle(),
                        ):const CircularProgressIndicator(color: Colors.brown,backgroundColor: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                      child: Text("Have a great day ahead😀",style: TextStyle(color: Colors.brown[900],fontSize: 24,fontWeight: FontWeight.w500),)
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
