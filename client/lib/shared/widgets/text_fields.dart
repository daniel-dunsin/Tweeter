import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

const focusBorder = Border();

class ContainedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String? value)? onChangeValue;
  final String? labelText;
  final FormFieldValidator<String?>? validator;
  final bool? fullWidth;
  final bool? obscureText;
  final double? width;
  final double? height;
  final TextInputType? keyboardType;
  final bool? isTextArea;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? accentColor;
  final bool? enabled;
  final String? initialValue;
  final bool? centerLabel;

  const ContainedTextField({
    super.key,
    this.controller,
    this.onChangeValue,
    this.labelText,
    this.validator,
    this.fullWidth,
    this.obscureText,
    this.width,
    this.height,
    this.keyboardType,
    this.isTextArea,
    this.prefixIcon,
    this.suffixIcon,
    this.accentColor,
    this.enabled,
    this.initialValue,
    this.centerLabel,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    final containedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        color: appColors.secondaryForegroundColor,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(40),
      ),
    );

    return SizedBox(
      height: height ?? 64,
      width: fullWidth == true ? double.maxFinite : width ?? 200,
      child: TextFormField(
        onChanged: onChangeValue,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        style: TextStyle(
          color: enabled == false ? appColors.secondaryForegroundColor : appColors.iconColor,
          fontSize: 12,
        ),
        cursorColor: appColors.secondaryForegroundColor,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        initialValue: initialValue,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(99, 67, 67, 67),
          filled: true,
          label: centerLabel == true
              ? Center(
                  child: Text(labelText ?? ""),
                )
              : Text(labelText ?? ""),
          labelStyle: TextStyle(
            color: appColors.secondaryForegroundColor,
            fontSize: 15,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: containedBorder,
          focusedBorder: containedBorder,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconColor: accentColor,
          prefixIconColor: accentColor,
        ),
        maxLines: isTextArea == true ? 4 : 1,
        minLines: isTextArea == true ? 4 : 1,
      ),
    );
  }
}

class UnderlinedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String? value)? onChangeValue;
  final String? labelText;
  final FormFieldValidator<String?>? validator;
  final bool? fullWidth;
  final bool? obscureText;
  final double? width;
  final double? height;
  final TextInputType? keyboardType;
  final bool? isTextArea;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? accentColor;
  final bool? enabled;
  final String? initialValue;

  const UnderlinedTextField({
    super.key,
    this.controller,
    this.onChangeValue,
    this.labelText,
    this.validator,
    this.fullWidth,
    this.obscureText,
    this.width,
    this.height,
    this.keyboardType,
    this.isTextArea,
    this.prefixIcon,
    this.suffixIcon,
    this.accentColor,
    this.enabled,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return SizedBox(
      height: height ?? 64,
      width: fullWidth == true ? double.maxFinite : width ?? 200,
      child: TextFormField(
        onChanged: onChangeValue,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        style: TextStyle(
          color: enabled == false ? appColors.secondaryForegroundColor : appColors.iconColor,
          fontSize: 12,
        ),
        cursorColor: appColors.secondaryForegroundColor,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          floatingLabelStyle: TextStyle(
            color: appColors.secondaryForegroundColor,
            fontSize: 12,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: appColors.secondaryForegroundColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.4,
              color: appColors.iconColor,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.4,
              color: Colors.red,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: appColors.secondaryForegroundColor,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconColor: accentColor,
          prefixIconColor: accentColor,
        ),
        maxLines: isTextArea == true ? 4 : 1,
        minLines: isTextArea == true ? 4 : 1,
      ),
    );
  }
}

class UnderlinedPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String? value)? onChangeValue;
  final String? labelText;
  final FormFieldValidator<String?>? validator;
  final bool? fullWidth;
  final bool? obscureText;
  final double? width;
  final double? height;
  final TextInputType? keyboardType;
  final bool? isTextArea;
  final bool? enabled;
  final Widget? prefixIcon;
  final String? initialValue;

  const UnderlinedPasswordTextField({
    super.key,
    this.controller,
    this.onChangeValue,
    this.labelText,
    this.validator,
    this.fullWidth,
    this.obscureText,
    this.width,
    this.height,
    this.keyboardType,
    this.isTextArea,
    this.enabled,
    this.prefixIcon,
    this.initialValue,
  });

  @override
  State<UnderlinedPasswordTextField> createState() => _UnderlinedPasswordTextFieldState();
}

class _UnderlinedPasswordTextFieldState extends State<UnderlinedPasswordTextField> {
  bool visible = false;

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return UnderlinedTextField(
      fullWidth: widget.fullWidth,
      width: widget.width,
      height: widget.height,
      isTextArea: widget.isTextArea,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      prefixIcon: widget.prefixIcon,
      suffixIcon: IconButton(
        icon: visible
            ? Icon(
                Icons.visibility_outlined,
                color: appColors.iconColor,
                size: 16,
              )
            : Icon(
                Icons.visibility_off_outlined,
                color: appColors.secondaryForegroundColor,
                size: 16,
              ),
        onPressed: toggleVisibility,
      ),
      accentColor: visible ? appColors.iconColor : appColors.secondaryForegroundColor,
      onChangeValue: widget.onChangeValue,
      labelText: widget.labelText,
      validator: widget.validator,
      obscureText: !visible,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
    );
  }
}
