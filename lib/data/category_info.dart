class Category {
  final int id;
  final String nameEn;
  final String nameJp;

  Category({this.id, this.nameEn, this.nameJp});
}

final List<Category> categories = [
  Category(id: 0, nameEn: 'general', nameJp: '総合'),
  Category(id: 1, nameEn: 'business', nameJp: 'ビジネス'),
  Category(id: 2, nameEn: 'technology', nameJp: 'テクノロジー'),
  Category(id: 3, nameEn: 'science', nameJp: '科学'),
  Category(id: 4, nameEn: 'health', nameJp: '健康'),
  Category(id: 5, nameEn: 'sports', nameJp: 'スポーツ'),
  Category(id: 6, nameEn: 'entertainment', nameJp: 'エンタメ'),
];
