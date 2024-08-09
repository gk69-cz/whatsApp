import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class CustomTextField extends StatelessWidget {

 final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final double? fontSize;
  final bool? autoFocus;
  final Function(String)? onChanged;

  const CustomTextField({super.key, this.hintText, this.readOnly, this.textAlign, this.keyboardType, this.prefixText, this.onTap, this.suffixIcon, this.onChanged, this.controller, this.fontSize, this.autoFocus});

 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      onTap: onTap,
      textAlign: textAlign ?? TextAlign.center,
      controller: controller,
      onChanged: onChanged, 
      style: TextStyle(fontSize: fontSize),
      autofocus: autoFocus ?? false,
      keyboardType: readOnly == null ? keyboardType:null,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText:hintText,
        hintStyle: TextStyle(
          color: context.theme.greyColor
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Coolors.greenDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Coolors.greenDark,
          width: 2.0
          )
        )


      ),
    );
  }
}