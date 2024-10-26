import 'package:education_project/core/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileFormTextField extends StatelessWidget {
  const EditProfileFormTextField({
    required this.controller,
    required this.fieldText,
    this.label,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.readOnly,
    this.minHeight,
    this.maxLines,
  });

  final String? label;
  final String fieldText;
  final TextEditingController controller;
  final String? hintText;
  final Icon? prefixIcon;
  final bool? readOnly;
  final int? minHeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            fieldText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          labelText: label,
          hintText: hintText ?? '',
          prefixIcon: prefixIcon ?? const Icon(Icons.info_outline_sharp),
          readOnly: readOnly,
          minHeight: minHeight,
          maxHeight: maxLines,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
