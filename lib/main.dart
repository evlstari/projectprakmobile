import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'models/sourcepickimage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Akses Kamera dan Storage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  //deklarasi variabel image bertipe XFile untuk menampung data berupa image dari gallery/camera
  //tipe xFile dapat dipakai jika mengimport package dart:io
  XFile? image;
  //menggunakan fungsi class ImagePicker dari package Image_picker yg udh di tambahkan di dependenci tdi
  // object picker dipake untuk menampung source mana yang digunakan
  final ImagePicker picker = ImagePicker();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //method untuk mengambil image berdasarkan inputan dari user, apakah pick image menggunakan kamera atau dari gallery
  //disini pake yang namanya fungsi asinkronus makanya ada istilah async dan await
  Future<void> getImage(ImageSource media) async{
    final pickImg = await picker.pickImage(source: media);

    setState(() {
      image = pickImg;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent),),
            height: 400,
            //mengecek apakah image ada atau tidak ?, jika tidak, akan menampilkan tulisan "No Image", jika iya, silahkan pick image 
            child: image == null ? const Text("No Image") : Image.file(File(image!.path)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            sourcepickimage("Pick Image from Kamera"),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(onPressed: () => getImage(ImageSource.camera), child: Icon(Icons.camera),),
          ],
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sourcepickimage("Pick Image from Gallery"),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(onPressed: () => getImage(ImageSource.gallery, ), child: Icon(Icons.file_open),),
          ],
          ),
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), 
      );
  }
}


