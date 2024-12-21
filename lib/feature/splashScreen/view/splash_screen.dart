import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:translator/configs/constants/app_constants.dart';
import 'package:translator/configs/extensions/mediaquery_extension.dart';
import 'package:translator/feature/translator/view_model/translator_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  late TranslatorViewModel translatorViewModel;

  @override
  void initState() {
    translatorViewModel = context.read<TranslatorViewModel>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        translatorViewModel.loadLanguages(context);
      },
    );
    super.initState();
    _setAnimationController();
  }

  void _setAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    _animationController?.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = context.mediaQueryWidth;
    double scrHeight = context.mediaQueryHeight;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              AppSvg.appIcon,
              height: scrHeight * 0.2,
              width: scrHeight * 0.2,
              colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(237, 82, 62, 0.505), BlendMode.srcIn),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: scrWidth - 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: const Color.fromRGBO(237, 82, 62, 0.987),
                      size: 30),
                ),
              ),
            ),
            (scrHeight * 0.05).height,
          ],
        ),
      ),
    );
  }
}
