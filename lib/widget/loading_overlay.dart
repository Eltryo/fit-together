import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;

  const LoadingOverlay({required this.child, Key? key}) : super(key: key);

  static LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: const Opacity(
                opacity: 0.8,
                child: ModalBarrier(
                  dismissible: false,
                  color: AppColors.loadingBackgroundColor,
                )),
          ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
      ],
    );
  }

  void showLoadingScreen() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoadingScreen() {
    setState(() {
      _isLoading = false;
    });
  }
}
