import 'package:flutter/material.dart';
import 'package:simple/ui/components/text_widgets.dart';
import 'package:simple/ui/utils/colors.dart';

Widget buttonWithBorder(
  String text, {
  Color? buttonColor,
  Color? textColor,
  Function()? onTap,
  Color? borderColor,
  FontWeight? fontWeight,
  double? fontSize,
  double? horiMargin,
  double? borderRadius,
  String? icon,
  Color? iconColor,
  double? height,
  double? width,
  bool busy = false,
  bool isActive = true,
  bool isGradient = true,
}) {
  return GestureDetector(
    onTap: isActive ? (busy ? null : onTap) : null,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horiMargin ?? 0),
      decoration: BoxDecoration(
          gradient: isGradient
              ? const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColor.darkBlue, AppColor.blue],
                )
              : null,
          color: isActive ? buttonColor : buttonColor!.withOpacity(.6),
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          border: Border.all(
              width: 1,
              color: isActive
                  ? isGradient
                      ? Colors.transparent
                      : (borderColor ?? Colors.transparent)
                  : const Color(0xffF6F6F6))),
      child: Center(
          child: busy
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          'assets/images/$icon.png',
                          height: 24,
                          width: 24,
                          color: iconColor,
                        ),
                      ),
                    regularText(
                      text,
                      color: isActive ? textColor : textColor!.withOpacity(.6),
                      fontSize: fontSize,
                      fontWeight: fontWeight ?? FontWeight.w700,
                    ),
                  ],
                )),
    ),
  );
}

Widget buttonWithBorder2(
  String text, {
  Color? buttonColor,
  Color? textColor,
  Function()? onTap,
  Color? borderColor,
  FontWeight? fontWeight,
  double? fontSize,
  double? horiMargin,
  double? borderRadius,
  String? icon,
  Color? iconColor,
  double? height,
  double? width,
  bool busy = false,
  bool isActive = true,
}) {
  return InkWell(
    onTap: isActive ? (busy ? null : onTap) : null,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horiMargin ?? 0),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [AppColor.darkBlue, AppColor.blue],
          ),
          color: isActive ? buttonColor : buttonColor!.withOpacity(.6),
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          border: Border.all(
              width: 1,
              color: isActive
                  ? (borderColor ?? Colors.transparent)
                  : const Color(0xffF6F6F6))),
      child: Center(
          child: busy
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          'assets/images/$icon.png',
                          height: 24,
                          width: 24,
                          color: iconColor,
                        ),
                      ),
                    regularText(
                      text,
                      color: isActive ? textColor : textColor!.withOpacity(.6),
                      fontSize: fontSize,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                  ],
                )),
    ),
  );
}

class NavButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  const NavButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.blue),
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Icon(
          iconData,
          size: 12,
        ),
      ),
    );
  }
}
