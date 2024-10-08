import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>() ??
        CustomThemeExtension.lightMode;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static const lightMode = CustomThemeExtension(
    circleImageColor: Color(0xFF25D366),
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    greyColor: Coolors.greyLight,
    blueColor: Coolors.blueLight,
    titleText: Colors.black,
    authAppbarTextColor: Coolors.greenLight,
    langBtnBgColor: Color(0x0fff7f8f),
    langBtnHighlightColor: Color(0xFFE8E8ED),
    photoIconBgColor: Color(0xFFF0F2F3),
    photoIconColor: Color(0xFF9DAAB3),
    profilePageBg: Color(0xFFF7F8FA),
    chatTextFieldBg: Colors.white,
    chatPageBgColor: Color(0xFFefe7de),
    chatPageDoodleColor: Colors.white70,
       senderChatBg: Color(0xFFEFFFDB),
        recieverChatBg: Color(0xFFFFFF),
  );
  static const darkMode = CustomThemeExtension(
    circleImageColor: Coolors.greenDark,
    backgroundColor: Color.fromARGB(191, 24, 34, 41),
    greyColor: Coolors.greyDark,
    blueColor: Coolors.blueDark,
    titleText: Colors.white,
    langBtnBgColor: Color(0xFF182229),
    authAppbarTextColor: Color(0xFFE9EDEF),
    langBtnHighlightColor: Color(0xFF09141a),
    photoIconBgColor: Color(0xFF283339),
    photoIconColor: Color(0xFF61717B),
    profilePageBg: Color(0xFF0B141A),
    chatTextFieldBg: Coolors.greyBackground,
    chatPageBgColor: Color(0xFF081419),
    chatPageDoodleColor: Color(0xFF172428),
    senderChatBg: Color(0xFF005c4b),
        recieverChatBg: Coolors.greyBackground,

  );
  final Color? circleImageColor;
  final Color? backgroundColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnBgColor;
  final Color? langBtnHighlightColor;
  final Color? titleText;
  final Color? authAppbarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;
  final Color? profilePageBg;
  final Color? chatTextFieldBg;
  final Color? chatPageBgColor;
  final Color? chatPageDoodleColor;
  final Color? senderChatBg;
    final Color? recieverChatBg;

  const CustomThemeExtension({
    this.circleImageColor,
    this.backgroundColor,
    this.greyColor,
    this.titleText,
    this.blueColor,
    this.langBtnBgColor,
    this.langBtnHighlightColor,
    this.authAppbarTextColor,
    this.photoIconBgColor,
    this.photoIconColor,
    this.profilePageBg,
    this.chatTextFieldBg,
    this.chatPageBgColor,
    this.chatPageDoodleColor,
     this.senderChatBg,
      this.recieverChatBg,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? circleImageColor,
    Color? backgroundColor,
    Color? greyColor,
    Color? titleText,
    Color? blueColor,
    Color? langBtnBgColor,
    Color? langBtnHighlightColor,
    Color? authAppbarTextColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
    Color? profilePageBg,
    Color? ChatTextFieldBg,
    Color? chatPageBgColor,
    Color? chatPageDoodleColor,
    Color? senderChatBg,
    Color? recieverChatBg,
  }) {
    return CustomThemeExtension(
        circleImageColor: circleImageColor ?? this.circleImageColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        titleText: titleText ?? this.titleText,
        greyColor: greyColor ?? this.greyColor,
        blueColor: blueColor ?? this.blueColor,
        authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
        langBtnBgColor: langBtnBgColor ?? this.langBtnBgColor,
        langBtnHighlightColor:
            langBtnHighlightColor ?? this.langBtnHighlightColor,
        photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
        photoIconColor: photoIconColor ?? this.photoIconColor,
        profilePageBg: profilePageBg ?? this.profilePageBg,
        chatTextFieldBg: ChatTextFieldBg ?? this.chatTextFieldBg,
        chatPageBgColor: chatPageBgColor ?? this.chatPageBgColor,
         senderChatBg: senderChatBg ?? this.senderChatBg,
        recieverChatBg: recieverChatBg ?? this.recieverChatBg,   
        chatPageDoodleColor: chatPageDoodleColor ?? this.chatPageDoodleColor);
  
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
        circleImageColor:
            Color.lerp(circleImageColor, other.circleImageColor, t),
        photoIconBgColor:
            Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
        photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
        langBtnHighlightColor:
            Color.lerp(langBtnHighlightColor, other.langBtnHighlightColor, t),
        titleText: Color.lerp(titleText, other.titleText, t),
        authAppbarTextColor:
            Color.lerp(authAppbarTextColor, other.authAppbarTextColor, t),
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
        greyColor: Color.lerp(greyColor, other.greyColor, t),
        blueColor: Color.lerp(blueColor, other.blueColor, t),
        langBtnBgColor: Color.lerp(langBtnBgColor, other.langBtnBgColor, t),
        profilePageBg: Color.lerp(profilePageBg, other.profilePageBg, t),
        chatPageBgColor: Color.lerp(chatPageBgColor, other.chatPageBgColor, t),
        chatPageDoodleColor:Color.lerp(chatPageDoodleColor, other.chatPageDoodleColor, t),
         senderChatBg:Color.lerp(senderChatBg, other.senderChatBg, t),
          recieverChatBg:Color.lerp(recieverChatBg, other.recieverChatBg, t),
        chatTextFieldBg: Color.lerp(chatTextFieldBg, other.chatTextFieldBg, t));
  }
}
