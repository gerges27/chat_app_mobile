import 'package:chat_app/auth/widgets/user_tile.dart';
import 'package:chat_app/auth_service.dart';
import 'package:chat_app/chat/chat_service.dart';
import 'package:chat_app/chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [],
      ),
      body: buildUserList(),
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
          children: snapshot.data!
              .map<Widget>((userData) => buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()?.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Get.to(
            () => ChatScreen(
              receiverEmail: userData['email'],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
