import 'dart:async';
import 'package:anywhere_variant_two/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController oneSecondController;
  late Animation<Offset> movingLogoAnimation;
  Timer? _timer;

  @override
  void initState() {
    oneSecondController = AnimationController(
      duration: const Duration(seconds: DurationConstant.d4),
      vsync: this,
    )..repeat(reverse: true);

    movingLogoAnimation = Tween(
            begin: const Offset(AppSize.s0, AppSize.s04),
            end: const Offset(AppSize.s0, AppSize.s06))
        .animate(
            oneSecondController.drive(CurveTween(curve: Curves.elasticIn)));

    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    oneSecondController.dispose();
    super.dispose();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: 4), _goNext);
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainWrapper()));
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageAssets.background),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              bottom: AppSize.s400,
              top: AppSize.s20,
              right: AppSize.s2,
              left: AppSize.s2,
              child: SlideTransition(
                position: movingLogoAnimation,
                child: Center(
                  child: Image.asset(
                    ImageAssets.back2,
                    scale: AppSize.s1_2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: he * 0.1),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(AppStrings.anywhere,
                          style: GoogleFonts.alexBrush(
                              textStyle: TextStyle(
                                  fontSize: AppSize.s60,
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold))),
                      Text(AppStrings.versionTwo,
                          style: GoogleFonts.alexBrush(
                              textStyle: TextStyle(
                                  fontSize: AppSize.s60,
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
