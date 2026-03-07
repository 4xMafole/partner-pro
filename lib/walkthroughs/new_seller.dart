import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/app_shared/components/walkthrough/walkthrough_tip/walkthrough_tip_widget.dart';

// Focus widget keys for this walkthrough
final containerSygszl1t = GlobalKey();

/// New Seller
///
/// First time new seller on the platform
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// dashboard_add_property
      TargetFocus(
        keyTarget: containerSygszl1t,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTipWidget(
              tip: 'Get started by adding your awesome property',
            ),
          ),
        ],
      ),
    ];
