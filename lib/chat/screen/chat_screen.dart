import 'package:chat_app/auth_service.dart';
import 'package:chat_app/chat/chat_service.dart';
import 'package:chat_app/chat/widget/chat_bubble.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/widgets/form_filed_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail, receiverId;
  const ChatScreen({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => scrollDown(),
          );
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, messageController.text);

      messageController.clear();
      scrollDown();
    }
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.person,
              ),
            ),
            const SizedBox(width: 15),
            Text(widget.receiverEmail),
          ],
        ),
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios)),
        iconTheme: const IconThemeData(
          color: kButtonsColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Expanded(child: buildMessagesList()),
            buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget buildMessagesList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverId, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          controller: scrollController,
          children: snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;
    return Container(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ChatBubble(
          message: data['message'],
          timestamp: data['timestamp'],
          isCurrentUser: isCurrentUser,
        ));
  }

  Widget buildUserInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FormFiledWidget(
            isPassword: false,
            hintText: "Type a message",
            controller: messageController,
            focusNode: focusNode,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ],
    );
  }
}
