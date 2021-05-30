import "package:json_annotation/json_annotation.dart";
part "auth_models.g.dart";

@JsonSerializable(createToJson: false)
class CountryModel {
  final String? name;

  CountryModel({this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);
}
