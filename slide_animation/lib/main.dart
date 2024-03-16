import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Image Picker Example'),
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
  List<XFile>? _imageFileList;

  void _pickImages() async {
    try {
      final List<XFile>? selectedImages = await ImagePicker().pickMultiImage(
        maxWidth: 500,
        maxHeight: 500,
      );
      if (selectedImages!.isNotEmpty) {
        setState(() {
          _imageFileList = selectedImages;
        });
      }
    } catch (e) {
      // Handle any errors
    }
  }

  Widget _buildImagePreview() {
    if (_imageFileList != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageFileList!.length,
        itemBuilder: (context, index) {
          if (kIsWeb) {
            return Image.network(_imageFileList![index].path);
          } else {
            return Image.file(File(_imageFileList![index].path));
          }
        },
      );
    } else {
      return const Text("No images selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildImagePreview(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Optional, if you want to keep the button at the bottom right
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _pickImages,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20), // Button size
                primary: Theme.of(context).floatingActionButtonTheme.backgroundColor, // Button color
              ),
              child: Icon(Icons.photo_library),
            ),
          ),
        ],
      ),
    );
  }
}
