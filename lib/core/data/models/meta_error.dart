class MetaError {
  final int code;
  final String status;
  final String message;

  MetaError({required this.code, required this.status, required this.message});

  factory MetaError.fromJson(Map<String, dynamic> json) => MetaError(
        code: json['code'] as int,
        status: json['status'] as String,
        message: json['message'] as String,
      );
}
