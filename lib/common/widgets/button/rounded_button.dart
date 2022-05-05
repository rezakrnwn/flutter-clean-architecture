import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color titleColor;
  final Color backgroundColor;
  final Color borderColor;
  final double width;
  final double height;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final String title;
  final Widget? postfixIcon;

  const RoundedButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 24,
    this.padding,
    this.postfixIcon,
    this.elevation = 0,
    this.title = "",
    this.titleColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                ),
              ),
            ),
            Visibility(
              visible: postfixIcon != null,
              child: Container(
                alignment: Alignment.centerRight,
                child: postfixIcon ?? Icon(Icons.report),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
