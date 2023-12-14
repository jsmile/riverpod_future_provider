import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future_provider/src/pages/users/users_providers.dart';

class FamilyDisposePage extends ConsumerWidget {
  const FamilyDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailProvider(1));
    ref.watch(userDetailProvider(2));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Dispose'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            OutlinedButton(
              onPressed: () {
                ref.invalidate(
                    userDetailProvider); // family provider invalidate
                // ref.invalidate(userDetailProvider(1));  // 개별 provider invalidate
              },
              child: Text(
                'Invalidate',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                return ref.refresh(UserDetailProvider(1));
              },
              child: Text(
                'Refresh',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
