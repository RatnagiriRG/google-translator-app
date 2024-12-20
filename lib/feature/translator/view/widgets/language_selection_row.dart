import 'package:flutter/material.dart';
import 'package:translator/feature/translator/view/screen/translator_screen.dart';
import 'package:translator/feature/translator/view/widgets/language_selector.dart';
import 'package:translator/feature/translator/view/widgets/language_selector_modal.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class LanguageSelectionRow extends StatelessWidget {
  final TranslatorViewModel viewModel;

  LanguageSelectionRow({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LanguageSelector(
            title: viewModel.fromLanguage?.name ?? "From",
            onTap: () => _showLanguageSelector(context, viewModel, true),
          ),
        ),
        SizedBox(width: 16.0),
        Icon(Icons.swap_horiz, color: Colors.white),
        SizedBox(width: 16.0),
        Expanded(
          child: LanguageSelector(
            title: viewModel.toLanguage?.name ?? "To",
            onTap: () => _showLanguageSelector(context, viewModel, false),
          ),
        ),
      ],
    );
  }

  void _showLanguageSelector(BuildContext context,
      TranslatorViewModel viewModel, bool isFromLanguage) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return LanguageSelectorModal(
          viewModel: viewModel,
          isFromLanguage: isFromLanguage,
        );
      },
    );
  }
}
