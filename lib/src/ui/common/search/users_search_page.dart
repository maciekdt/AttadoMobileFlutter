import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/services/users_service.dart';
import 'package:attado_mobile/src/ui/common/containers/rounded_text_label.dart';
import 'package:attado_mobile/src/ui/common/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsersSearchPage extends StatefulWidget {
  const UsersSearchPage({
    super.key,
    required this.usersService,
  });

  final UsersService usersService;

  @override
  State<UsersSearchPage> createState() => _UsersSearchPageState();
}

class _UsersSearchPageState extends State<UsersSearchPage> {
  List<User> _filterData(List<User> users, String? pattern) {
    if (pattern == null) return users;
    pattern = pattern.toLowerCase();
    return users
        .where((user) =>
            user.username.toLowerCase().contains(pattern!) ||
            '${user.firstName} ${user.surname}'.toLowerCase().contains(pattern))
        .toList();
  }

  void _onSelected(User user) {
    context.pop(user);
  }

  @override
  Widget build(BuildContext context) {
    return SearchList<User>(
      fetchData: widget.usersService.getUsers(),
      filterData: _filterData,
      listTileBuilder: (User user) => ListTile(
        leading: const Icon(Icons.person),
        title: Text(user.username),
        onTap: () => _onSelected(user),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.firstName.isNotEmpty || user.surname.isNotEmpty
                ? Text('${user.firstName} ${user.surname}')
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 18,
              ),
              child: RoundedTextLabel(
                icon: null,
                text: user.isActive ? 'Aktywny' : 'Nieaktywny',
                backgroundColor: user.isActive
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Theme.of(context).colorScheme.error,
              ),
            )
          ],
        ),
      ),
    );
  }
}
