// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) => PageModel(
      title: json['title'] as String?,
      appPageModel: json['appPageModel'] == null
          ? null
          : AppPageModel.fromJson(json['appPageModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
      'title': instance.title,
      'appPageModel': instance.appPageModel,
    };
