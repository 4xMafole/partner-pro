import '/app_components/wishlist_icon/wishlist_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'seller_preview_property_widget.dart' show SellerPreviewPropertyWidget;
import 'package:flutter/material.dart';

class SellerPreviewPropertyModel
    extends FlutterFlowModel<SellerPreviewPropertyWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for wishlist_icon component.
  late WishlistIconModel wishlistIconModel;
  // State field(s) for imageCarousel widget.
  CarouselSliderController? imageCarouselController;
  int imageCarouselCurrentIndex = 1;

  @override
  void initState(BuildContext context) {
    wishlistIconModel = createModel(context, () => WishlistIconModel());
  }

  @override
  void dispose() {
    wishlistIconModel.dispose();
  }
}
