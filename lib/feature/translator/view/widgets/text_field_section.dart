import 'package:flutter/material.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TextFieldSection extends StatelessWidget {
  final TranslatorViewModel viewModel;

  const TextFieldSection({super.key, required this.viewModel});

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
              viewModel.fromLanguage?.name != null
                  ? "( ${viewModel.fromLanguage?.name ?? " "} )"
                  : "",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            fillColor: Colors.grey[900],
            filled: true,
            hintText: "Enter text...",
            hintStyle: const TextStyle(color: Colors.white60),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: viewModel.translate,
        ),
      ],
    );
  }
}
