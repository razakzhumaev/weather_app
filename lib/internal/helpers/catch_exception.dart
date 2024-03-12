import 'package:dio/dio.dart';

class CatchException {
  String? message;

  CatchException({this.message});

  static CatchException convertException(dynamic error) {
    if (error is DioException) {
      print(error);
      if (error.type == DioExceptionType.connectionTimeout) {
        print('CONNECTION_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.type == DioExceptionType.receiveTimeout) {
        print('RECIVE_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.response == null) {
        print('NO_INTERNET');
        return CatchException(message: 'Нет интернет соеденения');
      } else if (error.response!.statusCode == 400) {
        return CatchException(message: 'Заполните поле');
      } else if (error.response!.statusCode == 401) {
        print('401 - AUTH ERROR');
        return CatchException(message: 'Ошибка обновления токена');
      } else if (error.response!.statusCode == 404) {
        print('401 - AUTH ERROR');
        return CatchException(message: 'Не удалось ничего найти');
      } else if (error.response!.statusCode == 409) {
        return CatchException(message: error.response!.data["message"]);
      } else {
        return CatchException(message: 'Произошла системная ошибка');
      }
    }
    if (error is CatchException) {
      return error;
    } else {
      return CatchException(message: 'Произошла системная ошибка');
    }
  }
}
