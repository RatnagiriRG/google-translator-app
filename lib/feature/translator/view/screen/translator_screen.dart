import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/feature/translator/view/widgets/language_selection_row.dart';
import 'package:translator/feature/translator/view/widgets/text_field_section.dart';
import 'package:translator/feature/translator/view/widgets/translated_text_section.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TranslatorScreen extends StatelessWidget {
  const TranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Translator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Consumer<TranslatorViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(237, 82, 62, 0.987)),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.white.withOpacity(.4),
                  ),
                  const SizedBox(height: 16.0),
                  LanguageSelectionRow(viewModel: viewModel),
                  const SizedBox(height: 16.0),
                  TextFieldSection(viewModel: viewModel),
                  const SizedBox(height: 16.0),
                  TranslatedTextSection(viewModel: viewModel),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
