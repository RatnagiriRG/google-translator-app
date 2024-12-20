import 'package:flutter/material.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class LanguageSelectorModal extends StatelessWidget {
  final TranslatorViewModel viewModel;
  final bool isFromLanguage;

  const LanguageSelectorModal(
      {super.key, required this.viewModel, required this.isFromLanguage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Row(
            children: [
              Text(
                isFromLanguage ? "From" : "To",
                style: TextStyle(color: Colors.white.withOpacity(.4)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search languages",
              hintStyle: const TextStyle(color: Colors.white60),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: viewModel.filterLanguages,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.filteredLanguages.length,
            itemBuilder: (context, index) {
              final language = viewModel.filteredLanguages[index];
              final isSelected =
                  (isFromLanguage && language == viewModel.fromLanguage) ||
                      (!isFromLanguage && language == viewModel.toLanguage);
              return ListTile(
                onTap: () {
                  if (isFromLanguage) {
                    viewModel.selectFromLanguage(language);
                  } else {
                    viewModel.selectToLanguage(language);
                  }
                  Navigator.pop(context);
                },
                title: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color.fromRGBO(237, 82, 62, 0.987)
                        : Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
