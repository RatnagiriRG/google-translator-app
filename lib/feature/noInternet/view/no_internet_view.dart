import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translator/configs/components/bouncing_button_widget.dart';
import 'package:translator/configs/extensions/mediaquery_extension.dart';
import 'package:translator/feature/noInternet/view_model/no_internet_view_model.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    double scrWidth = context.mediaQueryWidth;
    double scrHeight = context.mediaQueryHeight;
    // ColorScheme colorScheme = context.colorScheme;
    // TextTheme textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          onTap: () async {
            if (context.read<NoInternetViewModel>().isConnected) {
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(
                msg: "Check Your Internet Connection",
              );
            }
          },
          child: BouncingButtonWidget(
            child: Container(
              width: scrWidth,
              height: scrHeight * 0.06,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(237, 82, 62, 0.987),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: scrHeight * 0.023,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_cellular_connected_no_internet_0_bar_sharp,
              size: scrHeight * 0.2,
              color: const Color.fromRGBO(237, 82, 62, 0.987),
            ),
            (scrHeight * 0.1).height,
            Center(
              child: Text(
                "No Internet Connection!",
                style: GoogleFonts.lexend(
                  fontSize: scrHeight * 0.024,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(237, 82, 62, 0.987),
                ),
              ),
            ),
            const Text(
              "Please check your internet Connection.\nit looks like you're not connected to\nthe internet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(237, 82, 62, 0.987),
              ),
            )
          ],
        ),
      ),
    );
  }
}
