import 'package:e_commer/data/api/api_client.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommandedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommandedProductRepo({required this.apiClient});

  Future<Response> getRecommandedProductList() async{
    return await apiClient.getData(AppConstrants.RECOMMENDED_PRODUCT_ULI);
  }
}