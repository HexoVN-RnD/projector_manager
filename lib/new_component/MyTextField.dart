import 'package:flutter/material.dart';
import 'package:responsive_dashboard/style/colors.dart';

class MyTextField extends StatefulWidget {
  double? width = 50;
  double? height = 50;
  TextEditingController textEditing;
  String textLable;
  String textHint;
  Function(String?)? onChanged;
  String? Function(String?)? validator;

  MyTextField({
    this.width,
    this.height,
    required this.textEditing,
    required this.textLable,
    required this.textHint,
    this.onChanged,
    this.validator,
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
        validator: widget.validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'This value cannot empty';
          }
        },
        onChanged: widget.onChanged ?? (value) {
          setState(() {
            // print(widget.textEditing.text);
          });
        },
        // style: TextStyle(color: AppColors.navy_blue),
        decoration: InputDecoration(
          hintText: widget.textHint,
          labelText: widget.textLable,
          labelStyle: TextStyle(color: AppColors.grey),
          // prefixIcon: Icon(Icons.mail),
          // icon: Icon(Icons.mail),
          suffixIcon: widget.textEditing.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close, color: AppColors.navy_blue,),
                  splashRadius: 1,
                  // splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      widget.textEditing.clear();
                    });
                  },
                ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.navy_blue),
              borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green),
              borderRadius: BorderRadius.circular(20)),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,

        // autofocus: true,
      ),
    );
  }
}
