import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A general, customizable TextInputField that is used all over the app.
/// The 'controller' is used to show and set the input text.
class RAInputField extends StatefulWidget {
  String hintText; /// Hint text to show in the input field
  TextEditingController controller; // Text controller to manage the input
  bool isPassword; // Whether the input is a password field or not
  IconData? icon; // Icon to show as prefix of input field
  Color? color; // Color of input field background
  Function? onNewFocus; // Callback function to call when input field is focused
  bool onlyNumbers; // Whether to allow only numbers as input or not
  int? charLimit; // Maximum length of input
  List<String>? quickSelect; // List of options for quick select dropdown
  RAInputField({
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.icon,
    this.color = Colors.black12,
    this.onNewFocus,
    this.onlyNumbers = false,
    this.charLimit,
    this.quickSelect,
    super.key,
  });

  @override
  State<RAInputField> createState() => _RAInputFieldState();
}

class _RAInputFieldState extends State<RAInputField> {
  FocusNode focusNode = FocusNode(); // Focus node for input field
  bool isPasswordVisible = false; // Whether the password is visible or not

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  /// Returns what is shown in the 'RAInputField'.
  /// HintText, (PrefixIcon), (ToggleVisibilityIcon)
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Colors.black26 : widget.color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        maxLength: (widget.charLimit == null) ? 1000 : widget.charLimit,
        keyboardType:
            widget.onlyNumbers ? TextInputType.number : TextInputType.text,
        inputFormatters: widget.onlyNumbers
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : [],
        focusNode: focusNode,
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
          if (widget.onNewFocus != null) {
            widget.onNewFocus!();
          }
        },
        textInputAction: TextInputAction.done,
        controller: widget.controller,
        obscureText: widget.isPassword && !isPasswordVisible,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: (widget.icon == null)
              ? null
              : Icon(
                  widget.icon,
                  color: focusNode.hasFocus ? Colors.black : Colors.black45,
                ),
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  icon: (isPasswordVisible
                      ? Icon(
                          Icons.visibility_off,
                          color: focusNode.hasFocus
                              ? Colors.black
                              : Colors.black45,
                        )
                      : Icon(
                          Icons.visibility,
                          color: focusNode.hasFocus
                              ? Colors.black
                              : Colors.black45,
                        )),
                  onPressed: () => setState(
                    () => isPasswordVisible = !isPasswordVisible,
                  ),
                )
              : ((widget.quickSelect == null)
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: 75,
                          items: widget.quickSelect!
                              .map((unit) => DropdownMenuItem<String>(
                                  value: unit, child: Text(unit)))
                              .toList(),
                          //value: widget.ing.unit,
                          onChanged: (value) {
                            setState(() {
                              widget.controller.text = value as String;
                            });
                          },
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
