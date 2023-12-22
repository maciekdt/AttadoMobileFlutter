class MyFilter {
  final int filterId;
  final String filterValue;
  final int filterType;
  final String filterName;
  final bool startingFilter;

  MyFilter({
    required this.filterId,
    required this.filterValue,
    required this.filterType,
    required this.filterName,
    required this.startingFilter,
  });

  factory MyFilter.fromJson(Map<String, dynamic> json) {
    return MyFilter(
      filterId: json["filterId"],
      filterValue: (json["filterValue"] as String).replaceAll(r'\', ''),
      filterType: json["filterType"],
      filterName: json["filterName"],
      startingFilter: json["startingFilter"],
    );
  }
}
