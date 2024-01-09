import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.textController,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.suffixIcon,
    this.iconVisibility,
    this.onChanged,
    this.enabled = true,
    this.onTap,
    this.errorText,
    super.key,
  });

  final TextEditingController textController;
  final String labelText;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool? iconVisibility;
  final onChanged;
  final bool enabled;
  final VoidCallback? onTap;
  final String? errorText;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _focusNode;
  Color _borderColor = const Color(0xffd3d8de);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus
            ? const Color(0xff6f7a85)
            : const Color(0xffd3d8de);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
            xsSize,
            xsSize / 2,
            xsSize / 4,
            xsSize / 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: _borderColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: widget.textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                fontSize: getRightFontSize(),
                color: getRightColor(),
              ),
              suffixIcon: _focusNode.hasFocus ? widget.suffixIcon : null,
            ),
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            obscureText: widget.iconVisibility ?? false,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            cursorColor: const Color(0xff6f7a85),
            onTap: widget.onTap,
          ),
        ),
        if (widget.errorText != null) minuscleSeparator,
        if (widget.errorText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Color getRightColor() {
    return _focusNode.hasFocus
        ? const Color(0xff666666)
        : widget.textController.text.isNotEmpty
            ? const Color(0xff666666)
            : const Color(0xffA0A0A0);
  }

  double getRightFontSize() {
    return _focusNode.hasFocus
        ? 20
        : widget.textController.text.isNotEmpty
            ? 20
            : smallText;
  }
}
