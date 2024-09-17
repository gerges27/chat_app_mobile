import 'package:chat_app/auth/widgets/user_tile.dart';
import 'package:chat_app/auth_service.dart';
import 'package:chat_app/chat/chat_service.dart';
import 'package:chat_app/core/theme/theme_provider.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void logout() {
    final AuthService authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
              color: kButtonsColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? const Icon(Icons.light_mode, color: kButtonsColor)
                : const Icon(Icons.dark_mode, color: kButtonsColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: buildUserList(),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        //  loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        // return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => buildUserListItem(userData)).toList(),
        );
      },
    );
  }

  Widget buildUserListItem(Map<String, dynamic> userData) {
    if (userData['email'] != authService.getCurrentUser()?.email) {
      return UserTile(
        email: userData['email'],
        uid: userData['uid'],
      );
    } else {
      return Container();
    }
  }
}
