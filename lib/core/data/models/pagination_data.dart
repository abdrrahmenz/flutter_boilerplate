class PaginationData<T> {
  final int lastPage;
  final int currentPage;
  final List<T> data;

  PaginationData({
    required this.lastPage,
    required this.currentPage,
    required this.data,
  });

  factory PaginationData.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    List<T> datas = <T>[];

    if (json['data'] != null) {
      json['data'].forEach((dynamic item) {
        datas.add(fromJsonT(item as Map<String, dynamic>));
      });
    }

    return PaginationData(
      data: datas,
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
    );
  }
}
