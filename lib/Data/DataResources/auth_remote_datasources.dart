import 'dart:convert';


import '../Models/Auth_model_respon.dart';
import '../Models/request/register_request_model.dart';
import '../../../common/Global_Variabel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../Models/request/login_request_model.dart';
import 'auth_local_datasources.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponModel>> register(
    RegisterRequestModel model) async {
      final headears = {
        'Accept' : 'application/json',
        'Content_Type' : 'application/json'
      };
      final response = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}/api/register'),
          headers: headears,
          body: model.toJson()
      );
      if (response.statusCode == 200) {
        return Right(AuthResponModel.fromJson(response.body));
      } else {
        return const Left('Server error');
      }
    }
  Future<Either<String, AuthResponModel>> login(
    LoginRequestModel model) async {
      final headears = {
        'Accept' : 'application/json',
        'Content_Type' : 'application/json'
      };
      final response = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}/api/register'),
          headers: headears,
          body: model.toJson()
      );
      if (response.statusCode == 200) {
        return Right(AuthResponModel.fromJson(response.body));
      } else {
        final obj = jsonDecode(response.body);
        return  Left(obj['message']);
      }
    }
  Future<Either<String,String>> logout()
    async {
    final token = await AuthLocalDatasource().getToken();
      final headears = {
        'Accept' : 'application/json',
        'Content_Type' : 'application/json',
        'Authorization' : 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
          headers: headears,
      );
      if (response.statusCode == 200) {
        return const Right('Logout Succes');
      } else {
        return const Left('Server Error');
      }
    }
  }