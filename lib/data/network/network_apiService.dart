import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ies_flutter_application/data/app_exception.dart';
import 'package:ies_flutter_application/data/network/base_apiServices.dart';

import '../../utils/constant.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url),
        headers:{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'apikey': Constants.apiKey,
      'Authorization': 'Bearer ${Constants.bearerToken}',
      },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': Constants.apiKey,
            'Authorization': 'Bearer ${Constants.bearerToken}',
          },
          body: jsonEncode(data));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
