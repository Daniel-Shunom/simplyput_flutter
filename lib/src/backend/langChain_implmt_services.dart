import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
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
    print(indexes);
    try {
      if (!indexes.contains(indexName)) {
        print("creating $indexName ...");
        await client.createIndex(
            //SPECIFYING THE ENVIRONMENTIN FLUTTER IS NECESSARY!!! DO NOT SKIP!!
            environment: dotenv.env['PINECONE_ENVIRONMENT']!,
            request: CreateIndexRequest(
                name: indexName,
                dimension: vectorDimension,
                metric: SearchMetric.cosine));
        print("creating index .... please wait for it to finish intializing");
        await Future.delayed(const Duration(seconds: 1));
      } else {
        print("$indexName already exists!");
      }
    } catch (e) {
      print(e);
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
    //TAKE OUT LATER
    print(queryEmbeddings);

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

      //TAKE OUT LATER
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
    print("Retrieving Pinecone index...");
    final index = await client.describeIndex(indexName: indexName);
    print("Pinecone index retrieved: ${index.name}");

    for (final doc in docs) {
      print("Processing document: ${doc.metadata['source']}");
      final text = doc.pageContent;

      const textSplitter = RecursiveCharacterTextSplitter(chunkSize: 1000);
      final chunks = textSplitter.createDocuments([text]);
      print("Text split into ${chunks.length} chunks");

      print("Embedding ${chunks.length} text chunks...");
      final embeddingArrays = await embeddings.embedDocuments(chunks);

      print(
          "Creating ${chunks.length} vectors with id, values, and metadata...");
      final documents = chunks.asMap().entries.map((entry) {
        final i = entry.key;
        final chunk = entry.value;
        return Document(
          pageContent: chunk.pageContent,
          metadata: {
            ...doc.metadata,
            'chunk': i,
            'id': 'doc_${doc.metadata['source']}_chunk_$i',
          },
        );
      }).toList();

      await langChainPinecone.addVectors(
        vectors: embeddingArrays,
        documents: documents,
      );
      print("Pinecone index updated with ${chunks.length} vectors");
    }
  }
}
