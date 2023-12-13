import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future_provider/src/provider/dio_provider.dart';

import '../../model/user.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  ref.onDispose(() {
    print('userListProvider disposed');
  });

  final dio = ref.watch(dioProvider);
  final respose = await dio.get('/users'); // 이미 dart map 객체로 변환되어 있음
  // throw Exception('Api Loading error');
  final userList = respose.data;
  final users = [
    for (final user in userList) User.fromJson(user),
  ];

  return users;
});

final userDetailProvider =
    FutureProvider.family.autoDispose<User, int>((ref, id) async {
  ref.onDispose(() {
    print('userDetailProvider disposed');
  });

  final response = await ref.watch(dioProvider).get('/users/$id');
  final user = User.fromJson(response.data);

  return user;
});
