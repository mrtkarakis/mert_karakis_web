// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPageModel _$AppPageModelFromJson(Map<String, dynamic> json) => AppPageModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      backend: json['backend'] as String?,
      videos: json['videos'] as List<dynamic>?,
      photos: json['photos'] as List<dynamic>?,
      technologies: json['technologies'] as List<dynamic>?,
      description: json['description'] as String?,
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ))
          .toList(),
      skills: json['skills'] as List<dynamic>?,
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppPageModelToJson(AppPageModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'backend': instance.backend,
      'videos': instance.videos,
      'photos': instance.photos,
      'technologies': instance.technologies,
      'description': instance.description,
      'projects': instance.projects,
      'skills': instance.skills,
      'contact': instance.contact,
    };
