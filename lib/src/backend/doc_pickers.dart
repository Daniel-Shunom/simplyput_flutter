import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

//Pick files from
void pickFiles() async {
  //open the file
  void openFile(PlatformFile file) {
    //set linuxByProcess to false and linuxUsegio to true
    OpenFile.open(file.path, linuxByProcess: false, linuxUseGio: true);
  }

  final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt']);
  if (pickedFile == null) return;
  print(pickedFile);

  final file = pickedFile.files.first;
  openFile(file);
}
