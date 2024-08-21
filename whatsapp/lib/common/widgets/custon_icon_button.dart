import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class custom_icon_button extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final Color? color;
  final double? size;
  final double? minWidth;
  final Color? background;
  final BoxBorder? border; 
  
  const custom_icon_button({
    super.key, required this.onTap, this.icon, this.color, this.size, this.minWidth, this.background, this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border
      ),
      child: IconButton(
          onPressed: onTap,
          splashColor: Colors.transparent,
          splashRadius: (minWidth ?? 45)-25,
          iconSize: size ?? 22,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: minWidth ?? 45,
            minHeight: minWidth ?? 45, 
            ),
          icon: Icon(
            icon,
            color: color ?? context.theme.greyColor,
          )),
    );
  }
}
