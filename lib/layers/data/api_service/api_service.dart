import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';

abstract class APIService<RESPONSE_TYPE> {
  final apiManager = APIManager.getInstance("https://dummyjson.com/");
  final String endpoint;
  APIService({required this.endpoint});

  Future<ApiManagerResponse<List<RESPONSE_TYPE>>> getAll({
    QueryParams? params,
    String? endpoint,
  }) async {
    final query = params != null ? "?${params.toString()}" : "";
    final res = await apiManager.makeRequest(
      endpoint: "${endpoint ?? this.endpoint}$query",
      requestType: RequestType.get,
    );
    if (res.isSuccess) {
      final data = fromJsonList(res.data);
      return res.copyWith(data: data);
    } else {
      return res.copyWith(data: []);
    }
  }

  Future<ApiManagerResponse<RESPONSE_TYPE>> getOne(String id) async {
    final res = await apiManager.makeRequest(
      endpoint: "$endpoint/$id",
      requestType: RequestType.get,
    );
    if (res.isSuccess) {
      final data = fromJson(res.data);
      return res.copyWith(data: data);
    } else {
      return res.copyWith(data: null);
    }
  }

  makeRequest() {}

  List<RESPONSE_TYPE> fromJsonList(json);
  RESPONSE_TYPE fromJson(json);
  fromCreate(json);
  fromUpdate(json);
  fromDelete(json);
}
