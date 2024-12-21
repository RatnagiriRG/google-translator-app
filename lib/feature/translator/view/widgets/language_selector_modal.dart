import 'package:flutter/material.dart';
import 'package:translator/configs/components/bouncing_button_widget.dart';
import 'package:translator/configs/extensions/mediaquery_extension.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class LanguageSelectorModal extends StatelessWidget {
  final TranslatorViewModel viewModel;
  final bool isFromLanguage;

  const LanguageSelectorModal(
      {super.key, required this.viewModel, required this.isFromLanguage});

  @override
  Widget build(BuildContext context) {
    double scrWidth = context.mediaQueryWidth;
    double scrHeight = context.mediaQueryHeight;
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
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(.5)),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                (scrWidth * 0.02).width,
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                (scrWidth * 0.02).width,
                SizedBox(
                  width: scrWidth * 0.7,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search languages",
                      hintStyle: TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: viewModel.filterLanguages,
                  ),
                ),
              ],
            ),
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
              return BouncingButtonWidget(
                child: ListTile(
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
                          : Colors.black.withOpacity(.6),
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
                ),
              );
            },
          ),
        ),
        viewModel.queryText.isNotEmpty
            ? SizedBox(
                height: scrHeight * 0.07,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        const TextSpan(
                          text: "There are ",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                        TextSpan(
                          text:
                              "${viewModel.filteredLanguages.length} Language",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: " with the letter ",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                        TextSpan(
                          text: viewModel.queryText,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
