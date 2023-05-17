import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/features/users/presentation/state/providers.dart';
import 'package:search_users/features/users/presentation/widgets/extensions.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(usersListProvider);

    return Expanded(
      child: data.when(
        error: (error, stackTrace) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (users) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(usersListProvider.notifier).loadUsers();
          },
          child: users.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth,
                      ),
                      child: const Center(
                        child: Text('No users found'),
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (_, index) => const SizedBox(height: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.avatarUrl != null &&
                                    user.avatarUrl!.isNotEmpty
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null ||
                                    user.avatarUrl!.isEmpty
                                ? Text(user.name[0].toUpperCase())
                                : null,
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              await ref
                                  .read(usersListProvider.notifier)
                                  .deleteUser(user);
                              messenger.toast('User deleted');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
