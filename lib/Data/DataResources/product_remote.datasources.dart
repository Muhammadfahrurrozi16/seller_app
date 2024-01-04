import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:seller_app_fic/Data/Models/add_product_respon.dart';
import 'package:seller_app_fic/Data/Models/request/product_request_model.dart';
import '../Models/image_respon_model.dart';
import 'package:http/http.dart' as http;
import 'package:seller_app_fic/Data/DataResources/auth_local_datasources.dart';
import '../../../common/Global_Variabel.dart';
import '../../Data/Models/Product_model_respon.dart';

class ProductRemoteDatarsources {
  Future<Either<String, ProductResponModel>> getProduct() async {
    final UserId = await AuthLocalDatasource().getUserId();
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/Products?user_id=$UserId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ProductResponModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, ImageRespon>> addImage(XFile image) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
      'Authorization': 'Bearer $token',
    };
    
    var request = http.MultipartRequest('POST', Uri.parse('${GlobalVariables.baseUrl}/api/image/uploud'));

    final filename = image.name;
    final bytes = await image.readAsBytes();
    final multiPartFile = http.MultipartFile.fromBytes('image', bytes,filename: filename);
    request.files.add(multiPartFile);
    request.headers.addAll(headers);
    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responselist = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responselist);

    if (statusCode == 200) {
      return Right(ImageRespon.fromJson(responseData));
    } else {
      return const Left('Server Error');
    }
  }
  Future<Either<String, AddProductResponseModel>> addProduct(ProductRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/Products'),
      headers: headers,
    );
    if (response.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  // Future<Either<String, ProductResponModel>> getProductsByCategory(int categoryId) async {
  //   final headers = {
  //     'Accept' : 'application/json',
  //     'Content-Type' : 'application/json',
  //   };
  //   final response = await http.get(
  //     Uri.parse('${GlobalVariables.baseUrl}/api/Products?category_id=$categoryId'),
  //     headers: headers,
  //   );
  //   if (response.statusCode == 200) {
  //     return Right(ProductResponModel.fromJson(response.body));
  //   } else {
  //     return const Left('Server Error');
  //   }
  // }
}