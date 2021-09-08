import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class AD {
  int bannerId;
  String bannerImg;

  AD({this.bannerId, this.bannerImg});

  factory AD.fromJson(Map<String, dynamic> json) => _$ADFromJson(json);

  Map<String, dynamic> toJson() => _$ADToJson(this);
}
