import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
// get请求的body日志拦截器
class GetBodyLogger extends Interceptor {
  final int maxWidth;
  GetBodyLogger({this.maxWidth = 90});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method.toUpperCase() == 'GET' && options.data != null) {
      final buffer = StringBuffer();
      buffer.writeln("╔╣ GET Request Body ║");
      buffer.writeln("║ ${options.data}");
      buffer.writeln("╚${'═' * maxWidth}╝");
      if (kDebugMode) print(buffer.toString());
    }
    handler.next(options);
  }
}
