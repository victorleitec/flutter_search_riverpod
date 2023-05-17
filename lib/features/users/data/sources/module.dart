import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/core/dio/module.dart';
import 'package:search_users/features/users/data/sources/user_remote_data_source.dart';
import 'package:search_users/features/users/data/sources/user_remote_data_source_impl.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return UserRemoteDataSourceImpl(dio: dio);
});
