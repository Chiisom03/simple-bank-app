import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple/models/auth_model.dart';
import 'package:simple/models/transactions_model.dart';
import 'package:simple/models/transfer_model.dart';

class TransactionsService {
  static String baseUrl = 'https://bank.veegil.com';
  static final _dio = Dio();

// All Transactions Setvice Function
  final transactionProvider = FutureProvider((ref) => getTransactions());
  static Future<TransactionsModel> getTransactions() async {
    Response response;
    try {
      response = await _dio.get('$baseUrl/transactions');
      if (response.statusCode == 200) TransactionsModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response != null) {
        throw  throw error.response?.statusMessage ?? 'Unexpected result';
      }
      throw 'Check your Internet Connection';
    }
    return TransactionsModel.fromJson(response.data);
  }

  // Transfer Service Function
  final loading = StateProvider<bool>((ref) => false);
  Future<TransferModel> sendTransfer(
      WidgetRef ref, Map<String, dynamic> data) async {
    ref.read(loading.notifier).state = true;
    Response response;
    try {
      response = await _dio.post("$baseUrl/accounts/transfer", data: data);
      return TransferModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          String errorMessage;
          try {
            errorMessage = TransferModel.fromJson(e.response?.data).message!;
          } catch (ee) {
            if (kDebugMode) {
              print(ee);
            }
            throw e.response?.statusMessage ?? 'Unexpected result';
          }
          throw errorMessage;
        }
      }
      if (kDebugMode) {
        print(e);
      }
      throw 'Unexpected result';
    } finally {
      ref.read(loading.notifier).state = false;
    }
  }


  // Withdrawal Service Function
  final isWithdrawing = StateProvider((ref) => false);
  Future<AuthModel> withdrawal(WidgetRef ref, Map<String, dynamic> data) async {
    Response response;
    ref.read(isWithdrawing.notifier).state = true;
    try {
      response = await _dio.post('$baseUrl/accounts/withdraw', data: data);
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
      ref.read(isWithdrawing.notifier).state = false;
    }
  }

}
