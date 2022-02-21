Images images = Images();

class Images {
  static final Images _images = Images._i();

  factory Images() {
    return _images;
  }

  Images._i();

  static const String _iconDir = "assets/icons";

  final String ic_empty_cart = "$_iconDir/ic_empty_cart.png";
}
