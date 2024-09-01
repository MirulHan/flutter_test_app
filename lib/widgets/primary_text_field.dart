import 'package:flutter/material.dart';

import '../style/colors.dart';
import 'primary_column.dart';
import 'primary_text.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.hintText,
    required this.label,
    this.onChanged,
    this.error,
    this.initialValue,
    required this.prefixIcon,
    this.isRequired = true,
    this.keyboardType,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.onTap,
    this.readOnly = false,
  });
  final String label;
  final String? hintText;
  final Function(String)? onChanged;
  final String? error;
  final String? initialValue;
  final Icon prefixIcon;
  final bool isRequired;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return PrimaryColumn(
      gap: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PrimaryText(
              label,
              fontSize: 14.0,
              color: AppColors.black,
            ),
            if (isRequired)
              PrimaryText(
                '*',
                fontSize: 14.0,
                color: AppColors.red,
              ),
          ],
        ),
        SizedBox(
          height: 48.0,
          child: TextField(
            onTap: onTap,
            readOnly: readOnly,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            focusNode: focusNode,
            keyboardType: keyboardType,
            controller: TextEditingController(text: initialValue),
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.darkGray,
                fontSize: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.only(
                bottom: 0.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.lightblue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.blue,
                ),
              ),
            ),
          ),
        ),
        if (error != null)
          PrimaryText(
            error!,
            fontSize: 12.0,
            color: AppColors.red,
          )
      ],
    );
  }
}
