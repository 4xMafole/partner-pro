import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'wishlist_icon_model.dart';
export 'wishlist_icon_model.dart';

class WishlistIconWidget extends StatefulWidget {
  const WishlistIconWidget({
    super.key,
    this.onWishlist,
    bool? isFavourite,
  }) : isFavourite = isFavourite ?? false;

  final Future Function(bool isChecked)? onWishlist;
  final bool isFavourite;

  @override
  State<WishlistIconWidget> createState() => _WishlistIconWidgetState();
}

class _WishlistIconWidgetState extends State<WishlistIconWidget> {
  late WishlistIconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishlistIconModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isSaved = widget.isFavourite;
      safeSetState(() {});
    });
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
        _model.isSaved = !_model.isSaved;
        safeSetState(() {});
        await widget.onWishlist?.call(
          _model.isSaved,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_model.isSaved)
            Icon(
              Icons.favorite_border,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
          if (_model.isSaved)
            Icon(
              Icons.favorite_sharp,
              color: FlutterFlowTheme.of(context).accent2,
              size: 24.0,
            ),
        ],
      ),
    );
  }
}
