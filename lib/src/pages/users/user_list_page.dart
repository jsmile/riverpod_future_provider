import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'users_providers.dart';

import 'user_detail_page.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref
        .watch(userListProvider); // FutureProvider 의 반환값 AsyncValue<List<User>>

    print('#######');
    print('userList: $userList');
    print(
        'isLoading: ${userList.isLoading},  isRefreshing: ${userList.isRefreshing}, isReloading: ${userList.isReloading}');
    print('hasValue: ${userList.hasValue},  hasError: ${userList.hasError}');
    print('#######');

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      // body: switch (userList) {
      //   AsyncData(value: final users) => ListView.separated(
      //       itemCount: users.length,
      //       separatorBuilder: (BuildContext context, int index) {
      //         return const Divider();
      //       },
      //       itemBuilder: (BuildContext context, int index) {
      //         final user = users[index];
      //         return ListTile(
      //           leading: CircleAvatar(
      //             child: Text(user.id.toString()),
      //           ),
      //           title: Text(user.name),
      //         );
      //       },
      //     ),
      //   AsyncError(error: final err) => Center(
      //       child: Text(
      //         err.toString(),
      //         style: const TextStyle(
      //           color: Colors.red,
      //           fontSize: 20,
      //         ),
      //       ),
      //     ),
      //   _ => const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   // AsyncLoading() => const Center(
      //   //   child: CircularProgressIndicator(),),
      // }
      body: userList.when(
        data: (users) {
          return RefreshIndicator(
            onRefresh: () async {
              return ref.invalidate(userListProvider);
            },
            color: Colors.red,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(), // 항상 스크롤 가능
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return UserDetailPage(userId: user.id);
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                    title: Text(user.name),
                  ),
                );
              },
            ),
          );
        },
        error: (err, st) {
          return Center(
            child: Text(
              err.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
