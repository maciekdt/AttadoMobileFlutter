class ListWithLength<T> {
  List<T> items;
  int totalElements;

  ListWithLength({
    required this.items,
    required this.totalElements,
  });

  factory ListWithLength.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ListWithLength(
      items: List<T>.from(json['items'].map((item) => fromJsonT(item))),
      totalElements: json['totalElements'],
    );
  }
}
