import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future_provider/src/pages/users/users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref
        .watch(userListProvider); // FutureProvider 의 반환값 AsyncValue<List<User>>

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: userList.when(
        data: (users) {
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user.id.toString()),
                ),
                title: Text(user.name),
              );
            },
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
