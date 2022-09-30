import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;

  static init (){
    dio=Dio(BaseOptions( baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true
    ));
  }

  static Future<Response> getData ({
  required String url,
    required Map<String,dynamic> query,
})async
  {
    return await dio!.get(url,queryParameters: query);
  }
}

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=81d40cce422e4cb5b487aabd87c7ba41