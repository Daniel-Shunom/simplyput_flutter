import 'package:langchain_core/src/documents/document.dart';
import 'package:simplyputapp/src/backend/langchain_service.dart';

class LangChainServiceImpl implements LangChainService {
  @override
  Future<void> createPineConeIndex(String indexName, int vectorDimension) {
    // TODO: implement createPineConeIndex
    throw UnimplementedError();
  }

  @override
  Future<String> queryPineConeVectorStore(String indexName, String query) {
    // TODO: implement queryPineConeVectorStore
    throw UnimplementedError();
  }

  @override
  Future<void> updatePineConeIndex(String indexName, List<Document> docs) {
    // TODO: implement updatePineConeIndex
    throw UnimplementedError();
  }
}
