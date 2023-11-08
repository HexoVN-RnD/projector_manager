import 'package:flutter/material.dart';
import 'package:responsive_dashboard/style/colors.dart';

class MyTextField extends StatefulWidget {
  double? width = 50;
  double? height = 50;
  TextEditingController textEditing;
  String textLable;
  String textHint;

  MyTextField({
    this.width,
    this.height,
    required this.textEditing,
    required this.textLable,
    required this.textHint,
  });
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField>
    with TickerProviderStateMixin {
  bool isShowSignInDialog = false;
  bool isChecked = false;
  bool isAccountCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.all(20),
      child: TextFormField(
        controller: widget.textEditing,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This value cannot empty';
          }
        },
        onTap: () {
          setState(() {
          });
        },
        decoration: InputDecoration(
          hintText: widget.textHint,
          labelText: widget.textLable,
          // prefixIcon: Icon(Icons.mail),
          // icon: Icon(Icons.mail),
          suffixIcon: widget.textEditing.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  splashRadius:1,
                  // splashColor: Colors.transparent,
                  onPressed: () => widget.textEditing.clear(),
                ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.navy_blue),
              borderRadius: BorderRadius.circular(20)),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        // autofocus: true,
      ),
    );
  }
}
