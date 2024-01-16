import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:movie/Network/api_links.dart';
import 'package:movie/Network/app_exceptions.dart';
import 'package:movie/Utils/app_constants.dart';
import 'package:movie/Utils/helper_functions.dart';

class ApiBaseHelper {
  static final httpClient = InterceptedClient.build(
    client: http.Client(),
    interceptors: [],
  );

  static Future<dynamic> postRequestWithoutBody(
      {required String endPoint}) async {
    http.Response response;
    try {
      response = await httpClient.post(
          (Uri.parse('${ApiLinks.apiBaseURL}$endPoint')),
          headers: {"Content-Type": "application/json"});
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> genericGetRequest({
    required String endPoint,
    required String base,
    Map<String, dynamic>? params,
    bool returnByteData = false,
  }) async {
    http.Response response;
    try {
      response = await httpClient.get(
        Uri.parse('$base$endPoint'),
        params: params,
      );
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response, returnBytes: returnByteData);
  }

  static Future<dynamic> httpPostRequestWithoutToken(
      {String? endPoint,
      Object? body,
      String base = ApiLinks.apiBaseURL}) async {
    http.Response response;
    try {
      response = await httpClient
          .post(Uri.parse('$base$endPoint'), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpGetRequest(
    String endPoint, {
    String base = ApiLinks.apiBaseURL,
    bool returnByteData = false,
    bool translation = true,
  }) async {
    http.Response response;
    try {
      response = await httpClient.get(Uri.parse('$base$endPoint'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        if (translation) 'Accept-Language': 'en-US',
      });
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }

    return _returnResponse(response, returnBytes: returnByteData);
  }

  static Future<dynamic> httpPostRequest(
    String endPoint, {
    Object? body,
    String base = ApiLinks.apiBaseURL,
  }) async {
    http.Response response;
    try {
      // String userId = await HelperFunction.getUserId;
      response = await httpClient.post(
        Uri.parse('$base$endPoint'),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Accept-Language': 'en-US',
          // if (authorized) 'userId': userId,
        },
      );
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      print('body ${json.encode(body)}');
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    // print('Body: ${json.encode(body)}');
    // print('Response: ${json.encode(response)}');
    return _returnResponse(response);
  }

  static Future<dynamic> httpPutRequest(String endPoint,
      {Object? body, String base = ApiLinks.apiBaseURL}) async {
    http.Response response;
    try {
      response = await httpClient
          .put(Uri.parse('$base$endPoint'), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpPatchRequest(String endPoint, Object body) async {
    http.Response response;
    try {
      response = await httpClient.patch(
          Uri.parse('${ApiLinks.apiBaseURL}$endPoint'),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpDeleteRequest(String endPoint,
      {Object? body}) async {
    http.Response response;
    try {
      response = await httpClient.delete(
          Uri.parse('${ApiLinks.apiBaseURL}$endPoint'),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (_) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpMultiPartRequest(String endPoint,
      {required Map<String, String> fields,
      http.MultipartFile? file,
      String base = ApiLinks.apiBaseURL}) async {
    http.Response response;
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$base$endPoint'));
      request.headers.addAll({
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      request.files.add(file!);
      request.fields.addAll(fields);
      response = await http.Response.fromStream(await request.send());
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetMsg);
    } on FormatException {
      throw FetchDataException(AppConstants.badResponseFormat);
    } on TimeoutException {
      throw FetchDataException(AppConstants.slowInternetMsg);
    } catch (ex) {
      throw FetchDataException(AppConstants.exceptionMessage);
    }
    if (response.statusCode == 401) {
      // await HelperFunction.refreshToken();
    }
    return _returnResponse(response);
  }
}

dynamic _returnResponse(http.Response response, {bool returnBytes = false}) {
  final jsonResponse = returnBytes && response.statusCode == 200
      ? response.bodyBytes
      : jsonDecode(response.body);
  String message = HelperFunction.utf8TextParsing(jsonResponse['message'])!;
  if (message.isEmpty) {
    message = AppConstants.exceptionMessage;
  }
  switch (response.statusCode) {
    case 200:
      return jsonResponse;
    case 400:
      throw BadRequestException(message);
    case 401:
      throw InvalidInputException(message);
    case 403:
      throw UnauthorisedException(message);
    case 404:
      throw FetchDataException(message);
    case 500:
    default:
      throw FetchDataException(message);
  }
}
