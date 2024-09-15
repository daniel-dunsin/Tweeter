// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class SettingsTileModel {
  IconData icon;
  String title;
  String description;
  String? route;

  SettingsTileModel({
    required this.icon,
    required this.title,
    required this.description,
    this.route,
  });

  SettingsTileModel copyWith({
    IconData? icon,
    String? title,
    String? description,
    String? route,
  }) {
    return SettingsTileModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      route: route ?? this.route,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon.codePoint,
      'title': title,
      'description': description,
      'route': route,
    };
  }

  factory SettingsTileModel.fromMap(Map<String, dynamic> map) {
    return SettingsTileModel(
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      title: map['title'] as String,
      description: map['description'] as String,
      route: map['route'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsTileModel.fromJson(String source) => SettingsTileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
