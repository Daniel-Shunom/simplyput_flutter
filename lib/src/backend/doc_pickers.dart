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
  try {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.first.path!);
      print('Selected file: ${file.path}');
      return file;
    } else {
      print('No file selected');
      return null;
    }
  } catch (e) {
    print('Error picking file: $e');
    return null;
  }
}

/// Reads the contents of a PDF file as bytes.
/// Returns a [List<int>] containing the file bytes if successful, or null if an error occurred.
Future<List<int>?> readPDFFile() async {
  try {
    File? file = await pickPDFFiles();
    if (file != null) {
      final bytes = await file.readAsBytes();
      print('File read successfully: ${bytes.length} bytes');
      return bytes;
    }
    return null;
  } catch (e) {
    print('Error reading file: $e');
    return null;
  }
}
