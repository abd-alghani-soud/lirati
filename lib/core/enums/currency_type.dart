
enum CurrencyType {
  usd('us-dollar', 'الدولار الأمريكي', '\$'),
  euro('euro', 'اليورو', '€'),
  turkey('turkish-lira', 'الليرة التركية', '₺');

  final String slug;
  final String nameAr;
  final String symbol;
  const CurrencyType(this.slug, this.nameAr, this.symbol);

}