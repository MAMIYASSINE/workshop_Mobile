class Film {
  final String title, image, description;
  final double price;

  const Film(this.title, this.image, this.description, this.price);

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'price': price,
    };
  }

  factory Film.fromMap(Map<String, Object?> map) {
    return Film(
      map['title'] as String,
      map['image'] as String,
      map['description'] as String,
      (map['price'] as num).toDouble(),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Film &&
            runtimeType == other.runtimeType &&
            title == other.title;
  }

  @override
  int get hashCode => title.hashCode;
}
