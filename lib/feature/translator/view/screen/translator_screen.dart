import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/feature/translator/model/translator_model.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  late TranslatorViewModel translatorViewModel;

  @override
  void initState() {
    translatorViewModel = context.read<TranslatorViewModel>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        translatorViewModel.loadLanguages();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TranslatorViewModel()..loadLanguages(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Text Translation', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Consumer<TranslatorViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _showLanguageSelector(context, viewModel, true),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  viewModel.fromLanguage?.name ?? "From",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Icon(Icons.swap_horiz, color: Colors.white),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _showLanguageSelector(context, viewModel, false),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  viewModel.toLanguage?.name ?? "To",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                      "Translate From (${viewModel.fromLanguage?.name ?? "-"})",
                      style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 16.0),
                  Text("Translate To (${viewModel.toLanguage?.name ?? "-"})",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      viewModel.translatedText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
      ),
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search languages",
                  hintStyle: TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
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
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.flag, color: Colors.white),
                    ),
                    title: Text(
                      language.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check, color: Colors.orange)
                        : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
