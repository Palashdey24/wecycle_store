import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/presentation/main_screen/pages/main_content_screen.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/side_menu.dart';

final fsApis = FirebaseApi();

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  var slideOpen = false;
  static const int kDurationMiSec = 200;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: kDurationMiSec))
      ..addListener(
        () {
          setState(() {});
        },
      );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn));
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = PhoneSize.deviceWidth(context);

    return Scaffold(
      backgroundColor: AppColor.kDarkColor,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: kDurationMiSec),
                curve: Curves.bounceInOut,
                left: !slideOpen ? -screenWidth / 1.5 : 0,
                child: const SideMenu()),
            Transform.translate(
              offset: Offset(_animation.value * (screenWidth / 1.5), 0),
              child: Transform.rotate(
                angle: _animation.value * 0.2,
                child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: ClipRRect(
                        borderRadius: slideOpen
                            ? BorderRadius.circular(mediumGap)
                            : BorderRadius.zero,
                        child: const MainContentScreen())),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: kDurationMiSec),
              left: slideOpen ? (screenWidth / 1.5) - 50 : 20,
              top: normalGap,
              child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      slideOpen = !slideOpen;
                    });
                    slideOpen
                        ? _animationController.forward()
                        : _animationController.reverse();
                  },
                  icon: !slideOpen
                      ? const FaIcon(
                          FontAwesomeIcons.sliders,
                          size: 20,
                          color: Colors.white,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.circleXmark,
                          size: 25,
                          color: AppColor.kLightColor,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
