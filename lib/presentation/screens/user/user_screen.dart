import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/providers/user_provider.dart';
import '../../../domain/models/user_model/user.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  List<User> _users = [];

  Future<void> _getUsers() async {
    try {
      final userResponse = await ref.read(getUsersProvider(ref).future);
      final List<User> users = userResponse.map((user) => User.fromUserDetailResponse(user)).toList();
      setState(() {
        _users = users;
      });
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  @override
  void initState() {
    super.initState();

   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

     _getUsers();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _users.isNotEmpty
              ? UserList(users: _users)
              : SizedBox(),
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;
  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserItem(user: user);
      },
    );
  }
}

class UserItem extends StatelessWidget {
  final User user;
  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name, style: Theme.of(context).textTheme.headline6),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.email, style: Theme.of(context).textTheme.bodyText2),
          if (user.phone.isNotEmpty) Text(user.phone, style: Theme.of(context).textTheme.caption),
          if (user.street.isNotEmpty) Text(user.street, style: Theme.of(context).textTheme.caption),
          if (user.companyName.isNotEmpty) Text(user.companyName, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}