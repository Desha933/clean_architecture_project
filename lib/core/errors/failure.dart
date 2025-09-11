// failure.dart

import 'package:dio/dio.dart';

abstract class Failure {
  String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connectionTimeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data!);
      case DioExceptionType.cancel:
        return ServerFailure('Reqest canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('opps there was an error');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not fount , please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is problem with server , please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure('There was an error , please try again');
    }
  }
}

// abstract class Failure {
//   final String message;
//   const Failure(this.message);
// }

// // فشل في السيرفر (أخطاء API أو StatusCode)
// class ServerFailure extends Failure {
//   final int? statusCode;
//   const ServerFailure(String message, {this.statusCode}) : super(message);
// }

// // فشل في الاتصال بالشبكة
// class NetworkFailure extends Failure {
//   const NetworkFailure(String message) : super(message);
// }

// // فشل بسبب انتهاء المهلة (Timeout)
// class TimeoutFailure extends Failure {
//   const TimeoutFailure(String message) : super(message);
// }

// // فشل غير متوقع
// class UnexpectedFailure extends Failure {
//   const UnexpectedFailure(String message) : super(message);
// }

// // ميثود عام لتحويل خطأ Dio إلى Failure مناسب
// Failure mapDioErrorToFailure(DioException error) {
//   switch (error.type) {
//     case DioExceptionType.connectionTimeout:
//     case DioExceptionType.sendTimeout:
//     case DioExceptionType.receiveTimeout:
//       return TimeoutFailure("انتهت مهلة الاتصال بالإنترنت");

//     case DioExceptionType.badResponse:
//       return ServerFailure(
//         error.response?.data?["message"]?.toString() ??
//             "خطأ من السيرفر",
//         statusCode: error.response?.statusCode,
//       );

//     case DioExceptionType.connectionError:
//       return NetworkFailure("لا يوجد اتصال بالإنترنت");

//     case DioExceptionType.cancel:
//       return UnexpectedFailure("تم إلغاء الطلب");

//     case DioExceptionType.unknown:
//     default:
//       return UnexpectedFailure(error.message ?? "خطأ غير متوقع");
//   }
// }
