import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';

// Pick files from file browser
Future<String?> pickFiles() async {
  // Open the file
  void openFile(PlatformFile file) {
    // Set linuxByProcess to false and linuxUsegio to true
    OpenFile.open(file.path!, linuxByProcess: false, linuxUseGio: true);
  }

  final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    allowCompression: true,
    type: FileType.any, /*allowedExtensions: ['pdf', 'txt']*/
  );

  if (pickedFile != null) {
    final file = pickedFile.files.first;
    print(file.path);
    openFile(file);
    return file.path;
  }

  return null;
}

//use camera function to get image files live
Future<String> pickImage() async {
  final imgPicker = ImagePicker();

  String imgpath = '';

  try {
    final getImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (getImage != null) {
      imgpath = getImage.path;
    } else {
      imgpath = '';
    }
  } catch (e) {
    print(e.toString());
  }

  return imgpath;
}

//gets file as a document but doesnt open it
//this might be the main fucntion later hopefully
Future<File?> pickPDFFiles() async {
  // Open the file
  /*void openFile(PlatformFile file) {
    // Set linuxByProcess to false and linuxUsegio to true
    OpenFile.open(file.path!, linuxByProcess: false, linuxUseGio: true);
  }*/

  final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'] /*allowedExtensions: ['pdf', 'txt']*/
      );

  if (pickedFile != null) {
    final file = File(pickedFile.files.first.path!);
    print(file.path);
    //openFile(pickedFile.files.first);
    return file;
  }

  return null;
}

Future<List<int>?> readPDFFile() async {
  File? file = await pickPDFFiles();
  if (file != null) {
    return await file.readAsBytes();
  }
  return null;
}
