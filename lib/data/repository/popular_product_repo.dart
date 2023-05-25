import 'package:e_commer/data/api/api_client.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstrants.POPULAR_PRODUCT_ULI);
  }
}