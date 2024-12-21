import 'package:flutter/material.dart';
import 'package:translator/configs/components/bouncing_button_widget.dart';
import 'package:translator/feature/translator/view/widgets/language_selector.dart';
import 'package:translator/feature/translator/view/widgets/language_selector_modal.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class LanguageSelectionRow extends StatelessWidget {
  final TranslatorViewModel viewModel;

  const LanguageSelectionRow({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BouncingButtonWidget(
            child: LanguageSelector(
              title: viewModel.fromLanguage?.name ?? "From",
              onTap: () {
                viewModel.clearFilter();
                _showLanguageSelector(context, viewModel, true);
              },
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        BouncingButtonWidget(
          child: GestureDetector(
              onTap: () {
                viewModel.swapLanguages();
              },
              child: const Icon(Icons.swap_horiz, color: Colors.white)),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: BouncingButtonWidget(
            child: LanguageSelector(
                title: viewModel.toLanguage?.name ?? "To",
                onTap: () {
                  viewModel.clearFilter();
                  _showLanguageSelector(context, viewModel, false);
                }),
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
      shape: const RoundedRectangleBorder(
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
