import 'package:flutter/material.dart';
import 'package:baby_diary/common/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool enable;
  final ValueChanged<String>? onTextChanged;

  const CustomTextField(
      {Key? key,
        this.controller,
        this.errorText,
        this.hintText,
        this.minLines = 1,
        this.maxLines,
        this.maxLength,
        this.onTextChanged,
        this.enable = true})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(Constants.radius)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.red,
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Constants.radius)),
      borderSide: BorderSide(
        width: Constants.borderWidth,
        color: Constants.mainColor(),
      ),
    );
    final defaultBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Constants.radius)),
      borderSide: BorderSide(
        width: Constants.borderWidth,
        color: Constants.secondaryTextColor().withOpacity(0.4),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.enable,
          controller: widget.controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          style: TextStyle(
            color: widget.enable ? Constants.primaryTextColor() : Constants.secondaryTextColor(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            enabledBorder: defaultBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            disabledBorder: defaultBorder,
            focusedErrorBorder: errorBorder,
            fillColor:
            widget.enable ? Colors.white.withOpacity(0.6) : Constants.secondaryTextColor(),
            filled: true,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Constants.secondaryTextColor(),
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(fontSize: 0),
            counter: Container(),
            hintText: widget.hintText,
          ),
          onChanged: widget.onTextChanged,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        Visibility(
          visible: widget.errorText?.isNotEmpty == true,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.errorText ?? "",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
