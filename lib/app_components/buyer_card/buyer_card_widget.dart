import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'buyer_card_model.dart';
export 'buyer_card_model.dart';

class BuyerCardWidget extends StatefulWidget {
  const BuyerCardWidget({
    super.key,
    bool? isVisible,
  }) : isVisible = isVisible ?? true;

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
