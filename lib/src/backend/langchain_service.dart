import 'package:langchain/langchain.dart';

abstract class LangChainService {
  Future<void> createPineConeIndex(String indexName, int vectorDimension);
  Future<void> updatePineConeIndex(String indexName, List<Document> docs);
  Future<String> queryPineConeVectorStore(String indexName, String query);
}
