import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoaderScreen {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Color(0xffFAF9F6),
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            const SizedBox(
              height: 250,
            ),
            AnimationLoaderWidget(
              text: text,
              animated: animation,
              showAction: false,
            ),
          ]),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animated,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });
  final String text;
  final String animated;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animated,
              width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
