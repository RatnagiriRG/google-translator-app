import 'package:flutter/material.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TranslatedTextSection extends StatelessWidget {
  final TranslatorViewModel viewModel;

  const TranslatedTextSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Translate To ",
              style: TextStyle(color: Colors.white.withOpacity(.4)),
            ),
            Text(
              "(${viewModel.toLanguage?.name ?? "-"})",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 150,
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            viewModel.translatedText.isNotEmpty
                ? viewModel.translatedText
                : "Translation will appear here...",
            style: TextStyle(color: Colors.white.withOpacity(.6)),
          ),
        ),
      ],
    );
  }
}
