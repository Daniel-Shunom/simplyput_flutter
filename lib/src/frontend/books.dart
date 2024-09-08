import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:simplyputapp/src/backend/doc_pickers.dart';
import 'package:simplyputapp/src/backend/index_notifier.dart';
import 'package:simplyputapp/src/backend/query_notifier.dart';

final _formKey = GlobalKey<FormState>();

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 233, 219, 201),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffff6961),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.red.shade300])),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 219, 201),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              const Text("Books"),
              const SizedBox(
                height: 20,
              ),
              MUIOutlinedButton(
                  text: "Go to chatbot",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultView()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

//UPLOAD PDF SERVICE
//ON TAP, THIS FUNCTION WILL PICK THE PDF, PERFORM THE
//EMBEDDINGS AND UPLOAD IT TO THE PINECONE DATABASE
//VIA THE langchain_servica-implt function

executeOperation(BuildContext context, WidgetRef ref) async {
  List<int>? selectedFile = await readPDFFile();
  if (selectedFile != null) {
    await ref
        .read(indexNotifierProvider.notifier)
        .createAndUploadPineconeIndex();
  } else {
    if (context.mounted) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No PDF was selected")),
      );
    }
  }
}

//Hooks river pod widget for displaying the result? probably?
class ResultView extends HookConsumerWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //takes in the text and uses it as the "query"
    final queryTextController = useTextEditingController();
    //watches the query state
    final queryState = ref.watch(queryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffff6961),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.red.shade300])),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //the container that has the question and answer section
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.orange.shade200,
                            spreadRadius: 1,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 9,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text('Ask a question'),
                        Column(
                          children: [
                            MUIPrimaryInputField(
                                hintText: "How may I help you?",
                                controller: queryTextController,
                                filledColor: Colors.amber.shade50),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: MUIOutlinedButton(
                                  text: "Ask",
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    //queries the vector store!
                                    ref
                                        .read(queryNotifierProvider.notifier)
                                        .queryPineConeIndex(
                                            queryTextController.text);
                                  }),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: MUIPrimaryButton(
                                  text: "upload PDF",
                                  onPressed: () async {
                                    executeOperation(context, ref);
                                    //File? selectedFile = await pickPDFFiles();
                                    /*if (selectedFile != null) {
                                      String textFilePath =
                                          await convertPDFToTextAndSaveInDir();
                                      List<Document> documents =
                                          await fetchDocuments();
                                      await ref
                                          .read(indexNotifierProvider.notifier)
                                          .createAndUploadPineconeIndex();
                                    } else {
                                      //optional: show message if no file was picked
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No pdf was selected")))
                                    }*/
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (queryState.state == QueryEnum.loading)
                              const LinearProgressIndicator(),
                            if (queryState.state == QueryEnum.loaded)
                              Align(
                                alignment: Alignment.center,
                                child: Text(queryState.result),
                              )
                          ],
                        ),
                      ],
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
