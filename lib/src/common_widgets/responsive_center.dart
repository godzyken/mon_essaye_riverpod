import 'package:flutter/cupertino.dart';
import 'package:mon_essaye_riverpod/src/constants/breakpoints.dart';

class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter(
      {super.key,
      this.maxContentWidth = Breakpoints.desktop,
      this.padding = EdgeInsets.zero,
      required this.child});
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveSilverCenter extends StatelessWidget {
  const ResponsiveSilverCenter(
      {super.key,
      this.maxContentWidth = Breakpoints.desktop,
      this.padding = EdgeInsets.zero,
      required this.child});

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        padding: padding,
        child: child,
      ),
    );
  }
}
