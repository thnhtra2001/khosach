class CartItem {
  final String? id;
  final String? productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  // final String category;
  // final String author;
  // final String language;
  // final String coutry;
  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    // required this.category,
    // required this.author,
    // required this.language,
    // required this.coutry,
  });
  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
    // String? category,
    // String? author,
    // String? language,
    // String? coutry,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      // category: category ?? this.category,
      // author: author ?? this.author,
      // language: language ?? this.language,
      // coutry: coutry ?? this.coutry,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      // 'category': category,
      // 'author': author,
      // 'language': language,
      // 'coutry': coutry,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      // category: json['category'],
      // author: json['author'],
      // language: json['language'],
      // coutry: json['coutry'],
    );
  }
}
