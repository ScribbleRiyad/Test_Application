
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Utils/theme_styles.dart';
import '../../Widgets/custom_text_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeStyles.scaffoldBackground,

      ),
    );
  }

}


class SliverAppBar extends SliverPersistentHeaderDelegate {
  const SliverAppBar();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
    shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.2;
    double topPadding = MediaQuery.of(context).padding.top + 15;

    return Stack(
      children: [
        const BackgroundWave(
          height: 180,
        ),
        Positioned(
          top: topPadding + offset,
          left: 16,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Welcome to Test App',
                fontSize: 18,
                color: ThemeStyles.primaryTextColor,
                fontWeight: FontWeight.w900,
              ),
              CustomTextWidget(
                text: 'Home Screen',
                color: ThemeStyles.secondaryTextColor,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 180;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class BackgroundWave extends StatelessWidget {
  final double height;

  const BackgroundWave({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipPath(
        clipper: BackgroundWaveClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ThemeStyles.whiteColor, ThemeStyles.whiteColor],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    const minSize = 100.0;
    final p1Diff = ((minSize - size.height) * 0.6).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}