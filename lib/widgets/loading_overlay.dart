import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;

  const LoadingOverlay({
    required this.child,
    Key? key,
  }) : super(key: key);

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
        if (_isLoading) buildModalBarrier(),
        if (_isLoading) buildProgressIndicator(),
      ],
    );
  }

  Widget buildModalBarrier() {
    return const ModalBarrier(
      dismissible: false,
      color: Colors.transparent,
    );
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: Column(
        children: [
          Spacer(flex: 80),
          CircularProgressIndicator(),
          Spacer(flex: 20)
        ],
      ),
    );
  }

  void showLoadingScreen() {
    setState(
      () {
        _isLoading = true;
      },
    );
  }

  void hideLoadingScreen() {
    setState(
      () {
        _isLoading = false;
      },
    );
  }
}
