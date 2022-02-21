Strings strings = Strings();

final title = "Strings";

class Strings {
  static final Strings _strings = Strings._i();

  factory Strings() {
    return _strings;
  }

  Strings._i();

  final String app_name = 'Flutter GetX Example';
  final String welcome = 'Welcome';
  final String total = 'Total';
  final String checkout = 'CHECKOUT';
  final String continue_ = 'CONTINUE';
  final String my_cart = 'My Cart';
  final String wishlist = 'Wishlist';
}
