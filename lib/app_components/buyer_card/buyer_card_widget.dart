import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'buyer_card_model.dart';
export 'buyer_card_model.dart';

class BuyerCardWidget extends StatefulWidget {
  const BuyerCardWidget({
    super.key,
    bool? isVisible,
  }) : this.isVisible = isVisible ?? true;

  final bool isVisible;

  @override
  State<BuyerCardWidget> createState() => _BuyerCardWidgetState();
}

class _BuyerCardWidgetState extends State<BuyerCardWidget> {
  late BuyerCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BuyerCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
