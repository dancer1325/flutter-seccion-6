import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  // Form's attributes
  final String formProperty;
  final Map<String, String> formValues;
  // final Map<String, Dynamic> formValues;     // If we want to use different variety of attributes

  const CustomInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false, 
    required this.formProperty, 
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,     // Establish the focus once the Widget is instantiated
      initialValue: '',
      textCapitalization: TextCapitalization.words,   // Way to capitalize the text introduced
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: ( value ) => formValues[formProperty] = value,
      validator: (value) {      // Validations required by TextFormField
        if ( value == null ) return 'Este campo es requerido';
        return value.length < 3 ? 'Mínimo de 3 letras' : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,     // Mechanism to launch the validations not fulfilled in validator attribute
      decoration: InputDecoration(        // Decorate the TextFormField
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        // prefixIcon: Icon( Icons.verified_user_outlined ),
        suffixIcon: suffixIcon == null ? null : Icon( suffixIcon ),
        icon: icon == null ? null : Icon( icon ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10)
          )
        )
      )
    );
  }
}