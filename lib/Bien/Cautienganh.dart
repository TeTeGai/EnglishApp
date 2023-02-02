class Quote{

  String? id;
  String? content;
  String? author;
  String? authorId;
  List? tags;
  int? length;

  Quote(
      {this.id,
      this.content,
      this.author,
      this.authorId,
      this.tags,
      this.length});
  Quote.fromJson(Map json)
      :content = json['content'],
        id = json['_id'],
        author = json['author'],
        authorId = json['authorId'],
        tags = json['tags'],
        length = json['length'];

  String? getId()
  {
    return id;
  }

  String? getContent() {
    return content;
  }

  //Returns Author of the quote

  String? getAuthor() {
    return author;
  }

  //Returns Authors ID of the quote

  String? getAuthorId() {
    return authorId;
  }

  //Returns list of tag of the quote

  List? getTags() {
    return tags;
  }

  //Returns the length of the quote,no of alphabets

  int? getLength() {
    return length;
  }
}