import 'package:dio/dio.dart';

class DioManager {
  Dio _dio;

  DioManager._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://www.wanandroid.com/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {

      },
      onResponse: (Response response) {
        print('\n');
        print('=========== dio onResponse Start ===========');
        print('\n');
        print(response.toString());
        print('\n');
        print('=========== dio onResponse End   ===========');
        print('\n');
      },
      onError: (DioError e) {
        print('\n');
        print('!!!!!!!!!! dio OnError Start !!!!!!!!!!');
        print('\n');
        print(e.message);
        print('\n');
        print('!!!!!!!!!! dio OnError End   !!!!!!!!!!');
        print('\n');
      }
    ));
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  Dio get dio {
    return _dio;
  }

}
