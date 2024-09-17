import 'package:chat_app/core/theme/theme_provider.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormFiledWidget extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText, error;
  final bool isMandatory, isOptional, textArea, isPassword, readOnly;
  final void Function(String? value)? onChanged, onSubmitted;
  final TextStyle? hinStyle;
  final TextDirection? alignHint;
  final Alignment? align;
  final Widget? suffix;
  final Function()? suffixPressed;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  const FormFiledWidget({
    super.key,
    this.controller,
    this.keyboardType,
    this.label,
    this.hintText,
    this.error,
    this.isMandatory = false,
    this.isOptional = false,
    this.textArea = false,
    this.isPassword = false,
    this.onChanged,
    this.onSubmitted,
    this.hinStyle,
    this.alignHint,
    this.align,
    this.suffix,
    this.suffixPressed,
    this.textDirection,
    this.textInputAction,
    this.focusNode,
    this.autofillHints,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return SizedBox(
      // width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ---------------------------------- Label --------------------------------- */
          if (label != null)
            Container(
              child: label!.isNotEmpty && !isMandatory && !isOptional
                  ? Text(
                      label!,
                    )
                  : isMandatory || isOptional
                      ? Row(
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                label!,
                              ),
                            ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            const Text(
                              "*", // ? AppStrings.optional.tr : AppStrings.required.tr,
                              style: TextStyle(
                                // color: titleColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      : Container(),
            ),
          const SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: isDark ? kWhite : kBlack),
            focusNode: focusNode,
            readOnly: readOnly,
            textDirection: textDirection,
            onSaved: onSubmitted,
            controller: controller,
            minLines: textArea ? 8 : 1,
            maxLines: textArea ? 15 : 1,
            keyboardType: keyboardType,
            obscureText: isPassword,
            textInputAction: textInputAction ?? TextInputAction.go,
            onChanged: onChanged,
            autofillHints: autofillHints,
            validator: validator,
            cursorColor: isDark ? kWhite : kBlack,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: isDark ? kWhite.withOpacity(.5) : kBlack.withOpacity(.5),
              ),
              errorText: error ?? '',
              // error: Text(
              //   error ?? '',
              //   style: AppStyles.errorForm,
              // ),
              hintText: hintText ?? '',
              // hintStyle: AppStyles.hintStyle,
              fillColor: isDark ? const Color(0xFF4B4B4C) : Colors.white,
              alignLabelWithHint: true,
              // hintTextDirection: alignHint ?? TextDirection.ltr,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              filled: true,
              // fillColor: ColorManager.bkgTextInput,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: HexColor.fromHex("#B6B6B6"), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimary, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: HexColor.fromHex("#B6B6B6"), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: HexColor.fromHex("#B6B6B6"), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: HexColor.fromHex("#B6B6B6"), width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimary, width: 1),
              ),
              suffixIcon: suffix != null
                  ? GestureDetector(onTap: suffixPressed, child: suffix
                      //  Icon(
                      //   suffix,
                      //   color: kSecondary,
                      // ),
                      )
                  : const SizedBox(),
              // focusColor: isDark ? kWhite : kPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
