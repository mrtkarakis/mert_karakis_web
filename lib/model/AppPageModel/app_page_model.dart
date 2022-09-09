import 'package:json_annotation/json_annotation.dart';
import 'package:mert_karakis_web/model/ContactModel/contact_model.dart';

part 'app_page_model.g.dart';

@JsonSerializable()
class AppPageModel {
  final String? type;
  final String? title;
  final String? backend;
  final List? videos;
  final List? photos;
  final List? technologies;
  final String? description;
  final List<Map<String, String>?>? projects;
  final List? skills;
  final Contact? contact;
  const AppPageModel({
    this.type,
    this.title,
    this.backend,
    this.videos,
    this.photos,
    this.technologies,
    this.description,
    this.projects,
    this.skills,
    this.contact,
  });

  factory AppPageModel.fromJson(Map<String, dynamic> json) =>
      _$AppPageModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppPageModelToJson(this);
}
