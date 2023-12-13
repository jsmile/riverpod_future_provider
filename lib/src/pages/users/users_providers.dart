import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_future_provider/src/provider/dio_provider.dart';

import '../../model/user.dart';

part 'users_providers.g.dart';

// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('userListProvider disposed');
//   });

//   final dio = ref.watch(dioProvider);
//   final respose = await dio.get('/users'); // 이미 dart map 객체로 변환되어 있음
//   // throw Exception('Api Loading error');
//   final userList = respose.data;
//   final users = [
//     for (final user in userList) User.fromJson(user),
//   ];

//   return users;
// });

@riverpod
FutureOr<List<User>> userList(UserListRef ref) async {
  ref.onDispose(() {
    print('### userListProvider disposed');
  });

  final dio = ref.watch(dioProvider);
  final respose = await dio.get('/users'); // 이미 dart map 객체로 변환되어 있음
  // throw Exception('Api Loading error');
  final userList = respose.data;
  final users = [
    for (final user in userList) User.fromJson(user),
  ];

  return users;
}

// final userDetailProvider =
//     FutureProvider.family.autoDispose<User, int>((ref, id) async {
//   ref.onDispose(() {
//     print('### userDetailProvider( $id ) disposed');
//   });

//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);

//   return user;
// });

@riverpod
FutureOr<User> userDetail(UserDetailRef ref, int id) async {
  ref.onDispose(() {
    print('### userDetailProvider( $id ) disposed');
  });

  final response = await ref.watch(dioProvider).get('/users/$id');
  final user = User.fromJson(response.data);

  return user;
}
