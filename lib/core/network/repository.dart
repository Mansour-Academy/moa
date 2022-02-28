import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/network/remote/dio_helper.dart';
import '../error/exceptions.dart';
import '../models/government_model.dart';
import '../models/register_model.dart';
import 'local/cache_helper.dart';

abstract class Repository {
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<String, List<GovernmentModel>>> getAllGovernments();

  Future<Either<String, RegisterModel>> register({
    required String name,
    required String email,
    required String mobile,
    required String nationalityId,
    required String password,
    required String cPassword,
    required String address,
    required int governorateId,
  });

  Future<Either<String, RegisterModel>> getAllRequested();
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });

  @override
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: loginUrl,
          data: {
            'email': email,
            'password': password,
          },
        );

        return LoginModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        debugPrint(exception.error);
        // final f = exception.error;
        // final msg = _handleErrorMessages(f: f['message'],);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, RegisterModel>> register({
    required String name,
    required String email,
    required String mobile,
    required String nationalityId,
    required String password,
    required String cPassword,
    required String address,
    required int governorateId,
  }) async {
    return _basicErrorHandling<RegisterModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: registerUrl,
          data: {
            'name': name,
            'email': email,
            'mO_PHONE_NO': mobile,
            'nationalityNumber': nationalityId,
            'password': password,
            'confirM_PASSWORD': cPassword,
            'address': address,
            'governorateId': governorateId,
          },
        );

        return RegisterModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        debugPrint(exception.error);
        // final f = exception.error;
        // final msg = _handleErrorMessages(f: f['message'],);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, List<GovernmentModel>>> getAllGovernments() async {
    return _basicErrorHandling<List<GovernmentModel>>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: governmentUrl,
        );

        List<GovernmentModel> governmentsList = [
          GovernmentModel(
            id: 0,
            code: '0',
            description: 'اختر',
          ),
        ];

        f.data.forEach((e) {
          governmentsList.add(GovernmentModel.fromJson(e));
        });

        return governmentsList;
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        debugPrint(exception.error);
        // final f = exception.error;
        // final msg = _handleErrorMessages(f: f['message'],);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, RegisterModel>> getAllRequested() async {
    return _basicErrorHandling<RegisterModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: requestUrl,
          token: token
        );

        return RegisterModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        debugPrint(exception.error);
        // final f = exception.error;
        // final msg = _handleErrorMessages(f: f['message'],);
        return exception.message;
      },
    );
  }

  // @override
  // Future<Either<String, List<GovernmentModel>>> getAllRequested() async {
  //   return _basicErrorHandling<List<GovernmentModel>>(
  //     onSuccess: () async {
  //       final Response f = await dioHelper.get(
  //         url: requestUrl,
  //         token: token
  //       );
  //
  //       List<GovernmentModel> governmentsList = [
  //         GovernmentModel(
  //           id: 0,
  //           code: '0',
  //           description: 'اختر',
  //         ),
  //       ];
  //
  //       f.data.forEach((e) {
  //         governmentsList.add(GovernmentModel.fromJson(e));
  //       });
  //
  //       return governmentsList;
  //     },
  //     onServerError: (exception) async {
  //       debugPrint(exception.message);
  //       debugPrint(exception.code.toString());
  //       debugPrint(exception.error);
  //       // final f = exception.error;
  //       // final msg = _handleErrorMessages(f: f['message'],);
  //       return exception.message;
  //     },
  //   );
  // }
}

extension on Repository {
  // String _handleErrorMessages({final dynamic f}) {
  //   String msg = '';
  //   if (f is String) {
  //     msg = f;
  //   } else if (f is Map) {
  //     for (dynamic l in f.values) {
  //       if (l is List) {
  //         for (final s in l) {
  //           msg += '$s\n';
  //         }
  //       }
  //     }
  //     if (msg.contains('\n')) {
  //       msg = msg.substring(0, msg.lastIndexOf('\n'));
  //     }
  //     if (msg.isEmpty) {
  //       msg = 'Server Error';
  //     }
  //   } else {
  //     msg = 'Server Error';
  //   }
  //   return msg;
  // }

  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(ServerException exception)? onServerError,
    Future<String> Function(CacheException exception)? onCacheError,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return const Left('Server Error');
    } on CacheException catch (e, s) {
      // recordError(e, s);
      debugPrint(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return const Left('Cache Error');
    } catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}
