import 'package:dio/dio.dart';

abstract class BaseRepository {
  Dio get dioClient;
}
