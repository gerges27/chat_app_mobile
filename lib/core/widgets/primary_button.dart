import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
    this.width,
    this.height,
    this.isDisabled = false,
    this.color,
    this.isWhite = false,
    this.titleColor,
    this.fontWeight,
    this.fontSize,
  });
  final String title;
  final bool isLoading;
  final void Function()? onPressed;
  final double? width, height, fontSize;
  final bool isDisabled, isWhite;
  final Color? color;
  final Color? titleColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          )),
          backgroundColor: isWhite
              ? WidgetStateProperty.all(const Color(0xFFFFFFFF))
              : color != null
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return kPrimary.withOpacity(0.5);
                        } else if (states.contains(WidgetState.disabled)) {
                          return kDisabledButton;
                        }
                        return kPrimary; // Use the component's default.
                      },
                    ),
        ),
        onPressed: isLoading || isDisabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? const Center(
                    child: SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(
                        backgroundColor: kWhite,
                      ),
                    ),
                  )
                : Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? (isWhite ? kPrimary : Colors.white),
                      fontSize: fontSize ?? 16,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                    // textScaleFactor: 1.0,
                  ),
          ],
        ),
      ),
    );
  }
}
