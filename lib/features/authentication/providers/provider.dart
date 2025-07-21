import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/datasources/authentication_datasource_impl.dart';
import 'package:moodtracker/features/authentication/repositories/authentication_repository.dart';
import 'package:moodtracker/features/authentication/repositories/authentication_repository_impl.dart';

final authenticationRepositoryProvider =
    StreamNotifierProvider.autoDispose<AuthenticationRepository, bool>(
  () =>
      AuthenticationRepositoryImpl(datasource: AuthenticationDatasourceImpl()),
);
