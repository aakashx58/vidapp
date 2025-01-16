import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:video_feed/common/extension/text_theme_extension.dart';
import 'package:video_feed/styles/app_colors.dart';

class TTextField extends StatefulWidget {
  const TTextField({
    super.key,
    this.label,
    this.textEditingController,
    this.validator,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.enabled,
    this.textInputAction,
    this.minLines,
    this.maxLines = 1,
    this.initialText,
    this.textInputType,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.obscureText = false,
    this.focusedBorder,
    this.onEditingComplete,
    this.errorBorder,
    this.focusedErrorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.fontSize,
    this.leftPadding,
    this.suffixIcon,
    this.prefixIcon,
    this.filled = false,
    this.readOnly = false,
    this.fillColor,
    this.style,
    this.contentPadding,
    this.focusNode,
    this.hintStyle,
    this.onTap,
    this.autofocus,
    this.textCapitalization,
    this.searchQuery,
    this.cursorColor,
    this.onSaved,
    this.inputFormatters,
    this.maxLength,
  });

  final String? label;
  final String? hint;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Function(String? value)? onSaved;
  final VoidCallback? onTap;
  final void Function()? onEditingComplete;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autofocus;
  final String? initialText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final double? fontSize;
  final double? leftPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool filled;
  final bool readOnly;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final String? searchQuery;
  final Color? cursorColor;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TTextField> createState() => _TTextFieldState();
}

class _TTextFieldState extends State<TTextField> {
  String? initialValue;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.textEditingController ??
        TextEditingController(text: widget.initialText);
  }

  @override
  void didUpdateWidget(covariant TTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialText != widget.initialText) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        initialValue = widget.initialText;
        _textEditingController?.text = initialValue ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      controller: _textEditingController,
      cursorColor: widget.cursorColor,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      // onSaved: ,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      style: widget.style ??
          context.titleMedium?.copyWith(
            color: Colors.black,
          ),
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        border: widget.enabledBorder ??
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
              borderSide: BorderSide(color: AppColors.slate400),
            ),
        contentPadding: widget.contentPadding,
        enabledBorder: widget.enabledBorder,
        focusedBorder: widget.focusedBorder,
        errorBorder: widget.errorBorder,
        disabledBorder: widget.disabledBorder,
        focusedErrorBorder: widget.focusedErrorBorder,
        filled: widget.filled,
        fillColor: widget.fillColor,
        labelText: widget.label,
        hintStyle: widget.hintStyle ??
            context.titleMedium?.copyWith(
              color: AppColors.grey500,
            ),
        suffixIcon: widget.suffixIcon != null
            ? FittedBox(fit: BoxFit.scaleDown, child: widget.suffixIcon)
            : null,
        prefixIcon: widget.prefixIcon == null
            ? null
            : FittedBox(fit: BoxFit.scaleDown, child: widget.prefixIcon),
        hintText: widget.hint,
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }
}
