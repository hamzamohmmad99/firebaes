import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PlatformFile? pickFiles;
Future uploadFile()async{
  final path='image/${pickFiles!.name}';
  final file=File(pickFiles!.path!);
final ref = FirebaseStorage.instance.ref().child(path);
ref.putFile(file);
}




  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFiles = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            if(pickFiles!=null)
            Expanded(child: Container(
              color: Colors.blue[100],
              child: Image.file(File(pickFiles!.path!),
              width: double.infinity,
              fit: BoxFit.cover,),
            )),

            const SizedBox(height: 32,),

            ElevatedButton(onPressed:selectFile, child: const Text('Select fils')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: uploadFile, child: const Text('Upload fils')),
          ],
        ),
      ),
    );
  }
}
