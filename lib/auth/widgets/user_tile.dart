import 'package:chat_app/chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class UserTile extends StatelessWidget {
  final String email, uid;
  final void Function()? onTap;

  const UserTile({super.key, required this.email, this.onTap, required this.uid});

  @override
  Widget build(BuildContext context) {
    String getName() {
      final List<String> slicedEmail = email.split('@');
      return slicedEmail[0];
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => ChatScreen(
              userName: getName(),
              receiverId: uid,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  "https://ui-avatars.com/api/?name=${getName()}&background=D1C2E5&color=fff&length=1"),
            ),
            const SizedBox(width: 10),
            Text(
              getName().capitalize!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
