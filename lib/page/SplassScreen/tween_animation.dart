import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/opening/wellcome.dart';



class Opacityanimate extends StatefulWidget {
  @override
  _OpacityanimateState createState() => _OpacityanimateState();
}

class _OpacityanimateState extends State<Opacityanimate> {
  Tween<double> tween = Tween(begin: 0.0, end: 1.0);
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 4),
        tween: tween,
        builder: (BuildContext context, double opacity, Widget child) {
          return Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/login.png',
                  height: size.width * 0.26,
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    text: '',
                    style: Get.theme.textTheme.headline4,
                    children: <TextSpan>[
                      TextSpan(
                        text: '',
                        style: Get.theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onEnd: () {
          Get.off(Wellcome());
        },
      ),
    );
  }
}