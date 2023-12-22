class GlobalSearchQuery {
  String query;
  int mode;

  GlobalSearchQuery({
    required this.query,
    required this.mode,
  });

  Map<String, dynamic> toJson() => {
        'query': query,
        'mode': mode,
      };
}
