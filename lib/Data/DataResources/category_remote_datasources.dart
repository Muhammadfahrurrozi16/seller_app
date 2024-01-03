import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../common/Global_Variabel.dart';
import '../../Data/Models/Category_model_respon.dart';

class CategoryRemoteDataSources {
  Future<Either<String, CategoryResponModel>> getCategory() async {
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/categories'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(CategoryResponModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}