import 'package:json_annotation/json_annotation.dart';
import 'package:mert_karakis_web/model/AppPageModel/app_page_model.dart';

part 'page_model.g.dart';

@JsonSerializable()
class PageModel {
  final String? title;
  final AppPageModel? appPageModel;
  const PageModel({this.title, this.appPageModel});

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}

enum AppPageType {
  applications,
  mail,
  contacts,
  aboutMe,
  technologies,
  requestJob;
}
