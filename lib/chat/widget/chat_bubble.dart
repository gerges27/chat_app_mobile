import 'package:chat_app/core/theme/theme_provider.dart';
import 'package:chat_app/core/utils/app_styles.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Timestamp timestamp;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    String getTime() {
      // Convert Timestamp to DateTime
      DateTime dateTime = timestamp.toDate();

      // Create a DateFormat instance for the desired format
      DateFormat formatter = DateFormat('hh:mm a');

      // Format the DateTime object
      String formattedTime = formatter.format(dateTime);

      return formattedTime;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(
        minWidth: 100.0, // Minimum height
        maxWidth: 350.0, // Maximum height
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 6.0,
      ),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? isDark
                ? const Color(0xFF003C34)
                : const Color(0xFFE1FFD4)
            : !isDark
                ? kWhite
                : const Color(0xFF363637),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              message,
              style: AppStyles.white16Bold.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? kWhite : const Color(0xFF010101),
              ),
            ),
          ),
          const SizedBox(width: 7),
          Text(
            getTime(),
            style: AppStyles.white16Bold.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: isDark ? kWhite : const Color(0xFF010101),
            ),
          ),
        ],
      ),
    );
  }
}
