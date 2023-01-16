import 'package:flutter/material.dart';
import 'package:mon_essaye_riverpod/src/common_widgets/responsive_center.dart';
import 'package:mon_essaye_riverpod/src/constants/breakpoints.dart';

import '../constants/app_size.dart';

class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
          maxContentWidth: Breakpoints.tablet,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: child,
              ),
            ),
          )),
    );
  }
}
