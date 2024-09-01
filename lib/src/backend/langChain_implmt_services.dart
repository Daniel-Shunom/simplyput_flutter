import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_core/src/documents/document.dart';
import 'package:langchain_google/langchain_google.dart';
import 'package:langchain_pinecone/langchain_pinecone.dart';
import 'package:pinecone/pinecone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simplyputapp/src/backend/langchain_service.dart';

import 'core/config.dart';

//provides that service function that we made to the docs
final langChainServiceProvider = Provider<LangChainService>((ref) {
  final pineConeAPIKey = dotenv.env["PINECONE_API_KEY"]!;
  final googleGeminiAPIKey = dotenv.env["GOOGLE_G_AI_APIKEY"]!;

  final pineConeClient = PineconeClient(
    apiKey: pineConeAPIKey,
  );

  final embeddings = GoogleGenerativeAIEmbeddings(apiKey: googleGeminiAPIKey);

  final langchainPineCone = Pinecone(
      apiKey: pineConeAPIKey,
      indexName: ServiceConfig.indexName,
      embeddings: embeddings);

  //make sure to double check if it is the embedding model or the genAI model
  final googleGeminiAI = ChatGoogleGenerativeAI(
    apiKey: googleGeminiAPIKey,
  );

  return LangChainServiceImpl(
      client: pineConeClient,
      langChainPinecone: langchainPineCone,
      embeddings: embeddings,
      googleGemini: googleGeminiAI);
});

class LangChainServiceImpl implements LangChainService {
  final PineconeClient client;
  final Pinecone langChainPinecone;
  final GoogleGenerativeAIEmbeddings embeddings;
  final ChatGoogleGenerativeAI googleGemini;

  LangChainServiceImpl({
    required this.client,
    required this.langChainPinecone,
    required this.embeddings,
    required this.googleGemini,
  });

  @override
  //checks for existing pinecone indexes and creates one if it doesnt exist
  Future<void> createPineConeIndex(
      String indexName, int vectorDimension) async {
    print("checking $indexName");
    final indexes = await client.listIndexes();
    if (!indexes.contains(indexName)) {
      print("creating $indexName ...");
      await client.createIndex(
          request: CreateIndexRequest(
              name: indexName,
              dimension: vectorDimension,
              metric: SearchMetric.cosine));
      print("creating index .... please wait for it to finish intializing");
      await Future.delayed(const Duration(seconds: 5));
    } else {
      print("$indexName already exists!");
    }
  }

  @override
  //lets the user assk questions (query) the embeddings (doc contents)
  //this is the main function that the user will interact with
  Future<String> queryPineConeVectorStore(
      String indexName, String query) async {
    final queryEmbeddings = await embeddings.embedQuery(query);
    final result = await langChainPinecone.similaritySearchByVector(
        embedding: queryEmbeddings);

    if (result.isNotEmpty) {
      final concatPageContent = result.map((e) {
        //check if the concat metadata has a apge content key
        if (e.metadata.containsKey('pageContent')) {
          return e.metadata['pageContent'];
        } else {
          return " ";
        }
      }).join(" ");

      final docChain = StuffDocumentsQAChain(llm: googleGemini);
      final response = await docChain.call({
        'input_documents': [Document(pageContent: concatPageContent)],
        'question': query
      });

      print(result);

      return response["output"];
    } else {
      return "No results found";
    }
  }

  @override
  //retrieves index from pinecone vector store, takes the metadata from the document, splits it into chunks, and stores the vectors in the index
  //also embedds the metadata and returns it for retrieval
  Future<void> updatePineConeIndex(
      String indexName, List<Document> docs) async {
    print("retrieving pinecone index.....");
    final index = await client.describeIndex(indexName: indexName);
    print("pinecone index retrieved: ${index.name}");

    for (final doc in docs) {
      print("processing document: ${doc.metadata['source']}");
      final text = doc.pageContent;

      //splits text into chunks for vectorization
      const textSplitter = RecursiveCharacterTextSplitter(chunkSize: 1000);

      final chunks = textSplitter.createDocuments([text]);
      print("text split into ${chunks.length}");

      print(
          "calling google's generative AI embedding endpoint with ${chunks.length} text chunks to embed documents");

      //maps the doc split chunks according to the number of items in the list (number of chunks)
      final chunksMap = chunks
          .map((e) => Document(
              pageContent: e.pageContent.replaceAll(RegExp('/\n/g'), " "),
              metadata: doc.metadata))
          .toList();

      //converts text (metadata) into embeddings
      final embeddingArrays = await embeddings.embedDocuments(chunksMap);
      print("finished embedding arrays");
      print(
          "Creating ${chunks.length} vectors array with id, values, and metadata....");

      await langChainPinecone.addVectors(
          vectors: embeddingArrays, documents: docs);
      print("Pinecone index updated with ${chunks.length} vectors");
    }
  }
}
