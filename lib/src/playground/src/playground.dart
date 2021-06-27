//
import 'package:drishya_picker/src/playground/src/entities/playground_value.dart';
import 'package:drishya_picker/src/playground/src/widgets/playground_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'controller/playground_controller.dart';
import 'entities/playground_background.dart';
import 'widgets/playground_background.dart';
import 'widgets/playground_controller_provider.dart';
import 'widgets/playground_stickers.dart';

///
class Playground extends StatefulWidget {
  ///
  const Playground({
    Key? key,
    this.controller,
  }) : super(key: key);

  ///
  final PlaygroundController? controller;

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  late final PlaygroundController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PlaygroundController();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundControllerProvider(
      controller: _controller,
      child: ValueListenableBuilder<PlaygroundValue>(
        valueListenable: _controller,
        builder: (context, value, child) {
          final background = value.background is GradientBackground
              ? GradientBackgroundView(
                  background: value.background as GradientBackground,
                )
              : PhotoBackgroundView(
                  background: value.background as PhotoBackground,
                );
          return RepaintBoundary(
            key: _controller.playgroundKey,
            child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  // background
                  background,

                  //
                  PlaygroundStickers(controller: _controller),

                  //
                  PlaygroundOverlay(controller: _controller),

                  //
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
