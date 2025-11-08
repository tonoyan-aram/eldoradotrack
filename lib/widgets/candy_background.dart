import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

class CandyBackground extends StatelessWidget {
  const CandyBackground({
    super.key,
    required this.child,
    this.showDecorations = true,
  });

  final Widget child;
  final bool showDecorations;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFC2E9), Color(0xFFFFF4C6)],
        ),
      ),
      child: Stack(
        children: [
          if (showDecorations) IgnorePointer(child: _CandyDecorations()),
          child,
        ],
      ),
    );
  }
}

class _CandyDecorations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: -20,
            left: -10,
            child: _CandyAsset(
              asset: AppAssets.lollyRainbow,
              width: 200,
              opacity: 0.35,
            ),
          ),
          Positioned(
            bottom: -30,
            right: -20,
            child: _CandyAsset(
              asset: AppAssets.lollyDark,
              width: 210,
              opacity: 0.3,
            ),
          ),
          Positioned(
            top: 80,
            right: 24,
            child: _CandyAsset(
              asset: AppAssets.heart,
              width: 90,
              opacity: 0.45,
            ),
          ),
          Positioned(
            bottom: 90,
            left: 24,
            child: _CandyAsset(
              asset: AppAssets.donut,
              width: 120,
              opacity: 0.5,
            ),
          ),
          Positioned(
            bottom: 40,
            right: 120,
            child: _CandyAsset(
              asset: AppAssets.gemBlue,
              width: 80,
              opacity: 0.4,
            ),
          ),
          Positioned(
            top: 160,
            left: 32,
            child: _CandyAsset(
              asset: AppAssets.bearYellow,
              width: 100,
              opacity: 0.4,
            ),
          ),
          Positioned(
            top: -10,
            right: 140,
            child: _CandyAsset(
              asset: AppAssets.gemGreen,
              width: 100,
              opacity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _CandyAsset extends StatelessWidget {
  const _CandyAsset({
    required this.asset,
    required this.width,
    required this.opacity,
  });

  final String asset;
  final double width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(asset, width: width, fit: BoxFit.contain),
    );
  }
}
