class Book {
  final int? id;
  final String name;
  final String author;
  final String coverImage;
  final double rating;
  final String publicationDate;
  final String bio;

  Book(this.name, this.author, this.coverImage, this.rating, this.publicationDate, this.bio, [this.id]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'coverImage': coverImage,
      'rating': rating,
      'publicationDate': publicationDate,
      'bio': bio,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      map['name'],
      map['author'],
      map['coverImage'],
      map['rating'],
      map['publicationDate'],
      map['bio'],
      map['id'],
    );
  }
}
