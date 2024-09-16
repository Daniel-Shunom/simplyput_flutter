import 'dart:io';

import 'package:flutter/services.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_community/langchain_community.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simplyputapp/src/backend/core/config.dart';
import 'package:simplyputapp/src/backend/doc_pickers.dart';
import 'package:simplyputapp/src/backend/langChain_implmt_services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
part 'index_notifier.g.dart';

enum IndexState {
  initial,
  loading,
  loaded,
  error,
}

@riverpod
class IndexNotifier extends _$IndexNotifier {
  @override
  IndexState build() => IndexState.initial;

  Future<void> createAndUploadPineconeIndex(File pdfFile) async {
    final langChainService = ref.read(langChainServiceProvider);

    // Create the index
    await langChainService.createPineConeIndex(ServiceConfig.indexName, 1536);

    // Process the PDF file
    final pdfText = await extractTextFromPDF(pdfFile);
    final doc =
        Document(pageContent: pdfText, metadata: {'source': pdfFile.path});

    // Update the index with the processed document
    await langChainService.updatePineConeIndex(ServiceConfig.indexName, [doc]);
  }

  Future<String> extractTextFromPDF(File pdfFile) async {
    // Implement PDF text extraction here
    // You might need to use a package like `pdf_text` or `syncfusion_flutter_pdf`
    // For this example, let's assume we have a function that does this
    return await extractTextFromPDF(pdfFile);
  }

  //this function fetches documents from the pdf file
  //langchain in flutter does not have pdf loader unlike python
  //which is why we have to take this step to kinda make one
  Future<List<Document>> fetchDocuments() async {
    try {
      final textFileFromPDF = await convertPDFToTextAndSaveInDir();
      final loader = TextLoader(textFileFromPDF);
      final documents = await loader.load();

      return documents;
    } catch (e) {
      throw Exception("error creating pinecone documents");
    }
  }

  //converts to pdf for fetchDocuments method to use
  convertPDFToTextAndSaveInDir() async {
    try {
      //pickPDFFile might be the main function
      //for now this function gets the pdf but without loading
      List<int>? pdfFromAsset =
          await readPDFFile(); //since we got the path froma previous fucntion we just pass it here
      final document = PdfDocument(inputBytes: pdfFromAsset as Uint8List);
      // Extract text from the PDF
      String textExtract = PdfTextExtractor(document).extractText();
      //saving the extracted string to a local path
      final localPath = await _localPath;
      //turns the previous string into a file first
      File file = File("$localPath/output.txt");
      //writes the string of the new file into a variable
      final res = await file.writeAsString(textExtract);

      //disposes of the old document to free memory i guess
      document.dispose();

      //return res.path;
      return textExtract;
    } catch (e) {
      //if there is an error, it may be from sync fusion
      throw Exception("Error converting pdf to text");
    }
  }
}

//local path wherein the extracted text document will be used!
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
