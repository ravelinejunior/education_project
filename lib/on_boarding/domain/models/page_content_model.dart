import 'dart:convert';

import 'package:education_project/core/res/icons.dart';
import 'package:equatable/equatable.dart';

class PageContentModel extends Equatable {
  const PageContentModel({
    required this.title,
    required this.description,
    required this.image,
  });

  const PageContentModel.first()
      : this(
          title: 'Brand new curriculum',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingOne,
        );

  const PageContentModel.second()
      : this(
          title: 'Learn Flutter',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingTwo,
        );

  const PageContentModel.third()
      : this(
          title: 'Brand a fun atmosphere',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingThree,
        );

  const PageContentModel.fourth()
      : this(
          title: 'Easy to join to a team',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingFour,
        );

  const PageContentModel.fifth()
      : this(
          title: 'Learn Flutter',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingFive,
        );

  const PageContentModel.sixth()
      : this(
          title: 'Learn Flutter',
          description:
              'With the new Flutter App Template, you can quickly build an '
              'app with Flutter, without having to learn any new technologies.',
          image: MediaRes.onboardingSix,
        );

  factory PageContentModel.fromMap(Map<String, dynamic> map) {
    return PageContentModel(
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  factory PageContentModel.fromJson(String source) =>
      PageContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'PageContentModel(title: $title,'
        ' description: $description,'
        ' image: $image)';
  }

  final String title;
  final String description;
  final String image;

  @override
  List<Object> get props => [title, description, image];
}
