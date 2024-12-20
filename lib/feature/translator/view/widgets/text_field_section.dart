import 'package:flutter/material.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TextFieldSection extends StatelessWidget {
  final TranslatorViewModel viewModel;

  TextFieldSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Translate From ",
              style: TextStyle(color: Colors.white.withOpacity(.4)),
            ),
            Text(
              "(${viewModel.fromLanguage?.name ?? "-"})",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            fillColor: Colors.grey[800],
            filled: true,
            hintText: "Enter text...",
            hintStyle: TextStyle(color: Colors.white60),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: viewModel.translate,
        ),
      ],
    );
  }
}
