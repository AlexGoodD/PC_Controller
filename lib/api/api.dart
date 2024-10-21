import 'package:dio/dio.dart';
import 'package:pc_controller_master/api/connection_strings.dart';

enum ResponseTypeToken { ok, badRequest, serverError, clientError }

class Api {
  static final Dio _client = Dio();
  static const String _clientType = "MobileDevice";

  static Future<ResponseTypeToken> sendUrl(String value) async {
    final data = {"fromUser": _clientType, "url": value};

    if (ConnectionStrings.serverHostname.isEmpty) {
      return ResponseTypeToken.clientError;
    }

    try {
      final response =
      await _client.post(ConnectionStrings.getOpenWebApiUrl(), data: data);
      final code = response.statusCode;

      if (code != null) {
        if (code >= 400 && code < 500) {
          return ResponseTypeToken.badRequest;
        }
        if (code >= 500) {
          return ResponseTypeToken.serverError;
        }
        return ResponseTypeToken.ok;
      }
      return ResponseTypeToken.badRequest;

    } catch (exception) {
      return ResponseTypeToken.clientError;
    }

  }

  static Future<ResponseTypeToken> sendBasicControl(String endpointURL) async {
    if (ConnectionStrings.serverHostname.isEmpty) {
      return ResponseTypeToken.clientError;
    }

    try {
      final response = await _client.post(endpointURL);
      final code = response.statusCode;

      if (code != null) {
        if (code >= 400 && code < 500) {
          return ResponseTypeToken.badRequest;
        }

        if (code >= 500) {
          return ResponseTypeToken.serverError;
        }

        return ResponseTypeToken.ok;
      }

      return ResponseTypeToken.badRequest;
    } catch (exception) {
      return ResponseTypeToken.clientError;
    }

  }

  static Future<ResponseTypeToken> sendComplexCommand(String endpoint, Map<String, dynamic> data) async {
    if (ConnectionStrings.serverHostname.isEmpty) {
      return ResponseTypeToken.clientError;
    }

    try {
      final response = await _client.post(endpoint, data: data);
      final code = response.statusCode;

      if (code != null) {
        if (code >= 400 && code < 500) {
          return ResponseTypeToken.badRequest;
        }
        if (code >= 500) {
          return ResponseTypeToken.serverError;
        }

        return ResponseTypeToken.ok;
      }
      return ResponseTypeToken.badRequest;
    } catch (exception) {
      return ResponseTypeToken.clientError;
    }
  }

}
