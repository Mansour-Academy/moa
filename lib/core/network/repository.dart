import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/models/post_model.dart';
import 'package:moa/core/models/simple_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/network/remote/dio_helper.dart';

import '../error/exceptions.dart';
import '../models/all_requests_model.dart';
import '../models/government_model.dart';
import '../models/register_model.dart';
import 'local/cache_helper.dart';

abstract class Repository {
  Future<Either<String, LoginModel>> login({
    required String companyName,
    required String firstField,
    required String secondField,
    required String deviceToken,
  });

  Future<Either<String, List<String>>> verifyCompanyDomain({
    required String domain,
  });

  Future<Either<String, List<PostModel>>> getPosts();

  Future<Either<String, SimpleModel>> like({
    required int postId,
  });

  Future<Either<String, SimpleModel>> removeLike({
    required int postId,
  });

  Future<Either<String, SimpleModel>> dislike({
    required int postId,
  });

  Future<Either<String, SimpleModel>> removeDisLike({
    required int postId,
  });

  Future<Either<String, SimpleModel>> sharePost({
    required int postId,
    required String source,
  });

  Future<Either<String, SimpleModel>> addComment({
    required int postId,
    required String comment,
  });

// Future<Either<String, RegisterModel>> register({
//   required String name,
//   required String email,
//   required String mobile,
//   required String nationalityId,
//   required String password,
//   required String cPassword,
//   required String address,
//   required int governorateId,
// });
//
// Future<Either<String, List<AllRequestsDataModel>>> getAllRequested();
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });

  @override
  Future<Either<String, List<String>>> verifyCompanyDomain({
    required String domain,
  }) async {
    return _basicErrorHandling<List<String>>(
      onSuccess: () async {
        List<String> fields = [];

        final Response f = await dioHelper.post(
          url: companyDomainUrl,
          query: {
            'companyName': domain,
          },
        );

        f.data.forEach((value) {
          fields.add(value);
        });

        return fields;
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
  Future<Either<String, LoginModel>> login({
    required String companyName,
    required String firstField,
    required String secondField,
    required String deviceToken,
  }) async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: loginUrl,
          data: {
            'companyName': companyName,
            'firstField': firstField,
            'secondField': secondField,
            'deviceToken': deviceToken,
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
  Future<Either<String, SimpleModel>> like({
    required int postId,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: likeUrl,
          token: token,
          query: {
            'postId': postId,
          },
        );

        return SimpleModel.fromJson(f.data);
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
  Future<Either<String, SimpleModel>> removeLike({
    required int postId,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: removeLikeUrl,
          token: token,
          query: {
            'postId': postId,
          },
        );

        return SimpleModel.fromJson(f.data);
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
  Future<Either<String, SimpleModel>> dislike({
    required int postId,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: dislikeUrl,
          token: token,
          query: {
            'postId': postId,
          },
        );

        return SimpleModel.fromJson(f.data);
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
  Future<Either<String, SimpleModel>> removeDisLike({
    required int postId,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: removeDislikeUrl,
          token: token,
          query: {
            'postId': postId,
          },
        );

        return SimpleModel.fromJson(f.data);
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
  Future<Either<String, SimpleModel>> sharePost({
    required int postId,
    required String source,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: sharePostUrl,
          token: token,
          data: {
            'postId': postId,
            'source': source,
          },
        );

        return SimpleModel.fromJson(f.data);
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
  Future<Either<String, SimpleModel>> addComment({
    required int postId,
    required String comment,
  }) async {
    return _basicErrorHandling<SimpleModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: commentUrl,
          token: token,
          data: {
            'postId': postId,
            'comment': comment,
          },
        );

        return SimpleModel.fromJson(f.data);
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

  //
  // @override
  // Future<Either<String, RegisterModel>> register({
  //   required String name,
  //   required String email,
  //   required String mobile,
  //   required String nationalityId,
  //   required String password,
  //   required String cPassword,
  //   required String address,
  //   required int governorateId,
  // }) async {
  //   return _basicErrorHandling<RegisterModel>(
  //     onSuccess: () async {
  //       final Response f = await dioHelper.post(
  //         url: registerUrl,
  //         data: {
  //           'name': name,
  //           'email': email,
  //           'mO_PHONE_NO': mobile,
  //           'nationalityNumber': nationalityId,
  //           'password': password,
  //           'confirM_PASSWORD': cPassword,
  //           'address': address,
  //           'governorateId': governorateId,
  //         },
  //       );
  //
  //       return RegisterModel.fromJson(f.data);
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

  // @override
  // Future<Either<String, List<GovernmentModel>>> getAllGovernments() async {
  //   return _basicErrorHandling<List<GovernmentModel>>(
  //     onSuccess: () async {
  //       final Response f = await dioHelper.get(
  //         url: governmentUrl,
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

  @override
  Future<Either<String, List<PostModel>>> getPosts() async {
    return _basicErrorHandling<List<PostModel>>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: getPostsUrl,
          token: token,
        );

        List<PostModel> requests = [];
        f.data.forEach((e) {
          requests.add(PostModel.fromJson(e));
        });

        // Iterable l = json.decode(f.data);
        // List<AllRequestsDataModel> requests = List<AllRequestsDataModel>.from(
        //     l.map((model) => AllRequestsDataModel.fromJson(model)));

        return requests;
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
