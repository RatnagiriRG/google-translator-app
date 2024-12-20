import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/feature/translator/view/widgets/language_selection_row.dart';
import 'package:translator/feature/translator/view/widgets/text_field_section.dart';
import 'package:translator/feature/translator/view/widgets/translated_text_section.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TranslatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TranslatorViewModel()..loadLanguages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Text Translation',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Consumer<TranslatorViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(237, 82, 62, 0.987)),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.white.withOpacity(.4),
                  ),
                  SizedBox(height: 16.0),
                  LanguageSelectionRow(viewModel: viewModel),
                  SizedBox(height: 16.0),
                  TextFieldSection(viewModel: viewModel),
                  SizedBox(height: 16.0),
                  TranslatedTextSection(viewModel: viewModel),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
