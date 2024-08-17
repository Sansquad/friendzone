import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget{

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({
    super.key,
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
  });


 @override
 _FormContainerWidgetState createState() => new _FormContainerWidgetState();
}


class _FormContainerWidgetState extends State<FormContainerWidget>{

  bool _obscureText = true;
  bool _hasText = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller!.addListener(_textListener);
    _focusNode.addListener(_focusListener); 
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_textListener);
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _textListener() {
    setState(() {
      _hasText = widget.controller!.text.isNotEmpty;
    });
  }

  void _focusListener() {
    setState(() {
      if (!_focusNode.hasFocus && widget.controller!.text.isEmpty) {
        _hasText = false;
      }


    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: 313,
      height: 47,

      child: new TextFormField(
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          ),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'BigShouldersDisplay',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          // filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: _focusNode.hasFocus || _hasText
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.inverseSurface,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.only(top: 5, left: 12),
          suffixIcon: new GestureDetector(
            onTap: (){
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child:
            widget.isPasswordField == true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,) : Text(""),
          ),
        ),
      ),
    );
  }
}