import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:search_users/features/users/presentation/state/providers.dart';
import 'package:search_users/features/users/presentation/widgets/todo_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search App'),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Consumer(
            builder: (context, ref, child) => SearchBar(
              controller: ref.watch(searchProvider),
              hintText: 'Search users',
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search),
              ),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ref.read(usersListProvider.notifier).clearSearch();
                  },
                ),
                IconButton.outlined(
                  onPressed: () {
                    ref.read(usersListProvider.notifier).searchUsers(
                          ref.read(searchProvider).text,
                        );
                  },
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.keyboard_return),
                ),
              ],
            ),
          ),
        ),
        const TodoList(),
      ],
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push('/new');
      },
      child: const Icon(Icons.add),
    );
  }
}
