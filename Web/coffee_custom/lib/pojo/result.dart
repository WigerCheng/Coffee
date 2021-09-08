class Result<T> {
  int code;
  String message;
  T data;

  Result(this.code, this.message, this.data);

  factory Result.fromJson(
          Map<String, dynamic> json, T Function(Object json) fromJsonT) =>
      _$ResultFromJson(json, fromJsonT);

  factory Result.fromJsonList(
          Map<String, dynamic> json, T Function(Object json) fromJsonT) =>
      _$ResultFromJsonList(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResultToJson(this, toJsonT);
}

Result<T> _$ResultFromJsonList<T>(
    Map<String, dynamic> json, T Function(Object json) fromJsonT) {
  var data;
  if (json['data'] != null) {
    data = ((json['data']) as List<T>).map((i) => fromJsonT).toList;
  }
  return Result<T>(
    json['code'] as int,
    json['message'] as String,
    data,
  );
}

Result<T> _$ResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  var data;
  if (json['data'] != null) {
    data = fromJsonT(json['data']);
  }
  return Result<T>(
    json['code'] as int,
    json['message'] as String,
    data,
  );
}

Map<String, dynamic> _$ResultToJson<T>(
  Result<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': toJsonT(instance.data),
    };
