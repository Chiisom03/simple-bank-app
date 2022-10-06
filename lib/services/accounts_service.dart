import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/models/accounts_model.dart';
import 'package:simple/models/auth_model.dart';

class AccountService {
  // All Accounts Service Function
  static String baseUrl = 'https://bank.veegil.com';
  static final _dio = Dio();

  final accountsProvider = FutureProvider((ref) => getAccounts());
  static Future<AccountsModel> getAccounts() async {
    Response response;
    response = await _dio.get('$baseUrl/accounts/list');
    return AccountsModel.fromJson(response.data);
  }

// Login Service Function
  final isLogging = StateProvider((ref) => false);
  Future<AuthModel> login(WidgetRef ref, Map<String, dynamic> data) async {
    Response response;
    ref.read(isLogging.notifier).state = true;
    try {
      response = await _dio.post('$baseUrl/auth/login', data: data);
      return AuthModel.fromJson(response.data);
    } catch (error) {
      if (error is DioError) {
        if (error.response?.data != null) {
          String errorMessage;
          try {
            errorMessage = AuthModel.fromJson(error.response?.data).message!;
          } catch (otherError) {
            if (kDebugMode) {
              print(otherError);
            }
            throw error.response?.statusMessage ?? 'Unexpected result';
          }
          throw errorMessage;
        }
      }
      if (kDebugMode) {
        print(error);
      }
      throw 'Unexpected result';
    } finally {
      ref.read(isLogging.notifier).state = false;
    }
  }

// Sign Up Service Function
  final isSignUp = StateProvider((ref) => false);
  Future<AuthModel> signup(WidgetRef ref, Map<String, dynamic> data) async {
    Response response;
    ref.read(isSignUp.notifier).state = true;
    try {
      response = await _dio.post('$baseUrl/auth/signup', data: data);
      return AuthModel.fromJson(response.data);
    } catch (error) {
      if (error is DioError) {
        if (error.response?.data != null) {
          String errorMessage;
          try {
            errorMessage = AuthModel.fromJson(error.response?.data).message!;
          } catch (otherError) {
            if (kDebugMode) {
              print(otherError);
            }
            throw error.response?.statusMessage ?? 'Unexpected result';
          }
          throw errorMessage;
        }
      }
      if (kDebugMode) {
        print(error);
      }
      throw 'Unexpected result';
    } finally {
      ref.read(isLogging.notifier).state = false;
    }
  }

}
