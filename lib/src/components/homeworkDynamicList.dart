import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:pinecone/pinecone.dart';

final pineConeAPIKey = dotenv.env["PINECONE_API_KEY"]!;
final googleGeminiAPIKey = dotenv.env["GOOGLE_G_AI_APIKEY"]!;

final pineConeClient = PineconeClient(
  apiKey: pineConeAPIKey,
);

class IndexHWItems extends StatelessWidget {
  const IndexHWItems({super.key, required this.items});
  final List<String> items;

  Future<Map<int, dynamic>> fileDisplayBuilder(List items) async {
    Map<int, dynamic> indexMap = {};
    List fileList =
        await pineConeClient.listIndexes(); // Removed unnecessary brackets

    items.asMap().forEach((index, item) {
      indexMap[index] = fileList;
    });

    return indexMap;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, dynamic>>(
      future: fileDisplayBuilder(items),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<int, dynamic> indexMap = snapshot.data!;
          return Column(
            children: [
              for (var entry in indexMap.entries)
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Text('Index ${entry.key}:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8.0),
                      Text('${entry.value}'),
                    ],
                  ),
                ),
            ],
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}


/*class indexHWItems extends StatelessWidget {
  const indexHWItems({super.key, required this.items});
  final List<String> items;

  //for each index in the list of indexes, all will be mapped to a dictionary
  Future<Map<int, dynamic>> fileDisplayBuilder(List items) async {
    Map<int, dynamic> indexMap = {};
    List fileList = await [pineConeClient.listIndexes()];

    items.asMap().forEach((index, item) {
      indexMap[index] = fileList;
    });

    return indexMap;
  }

  /*Map<int, dynamic> indexMapWidgetList(List items) {
    Map<int, dynamic> indexMap
  };*/

  @override
  Widget build(BuildContext context) {
    Future<Map<int, dynamic>> indexMap = fileDisplayBuilder(items);
    return Column(
      children: [
        for (var i in indexMap.entries) 
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: MUIPrimaryListTile(title: const Text("data"), description: Container()),
        )
      ],
    );
  }
}*/
