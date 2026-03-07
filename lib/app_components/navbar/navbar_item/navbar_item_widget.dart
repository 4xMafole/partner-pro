import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'navbar_item_model.dart';
export 'navbar_item_model.dart';

class NavbarItemWidget extends StatefulWidget {
  const NavbarItemWidget({
    super.key,
    String? label,
    required this.iconNav,
    bool? isActive,
    this.onTap,
  })  : label = label ?? 'Label',
        isActive = isActive ?? false;

  final String label;
  final Widget? iconNav;
  final bool isActive;
  final Future Function()? onTap;

  @override
  State<NavbarItemWidget> createState() => _NavbarItemWidgetState();
}

class _NavbarItemWidgetState extends State<NavbarItemWidget> {
  late NavbarItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.iconNav!,
          Text(
            widget.label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: widget.isActive
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ],
      ),
    );
  }
}
