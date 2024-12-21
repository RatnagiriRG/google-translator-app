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
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: viewModel.textEditingController,
                maxLines: 5,
                maxLength: 2300, // Set the maximum character limit
                decoration: const InputDecoration(
                  counterText: "", // Hides the default counter
                  hintText: "Enter text...",
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none, // Remove the border
                ),
                style: TextStyle(color: Colors.white.withOpacity(.6)),
                onChanged: (text) => viewModel.updateCharacterCount(text),
              ),
              const SizedBox(height: 8.0),
              Divider(color: Colors.white.withOpacity(.4)),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${viewModel.characterCount}/2300",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.4), fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
