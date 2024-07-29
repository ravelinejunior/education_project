import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.points,
    super.bio,
    super.enrolledCourseIds,
    super.profileImageUrl,
    super.followers,
    super.following,
    super.groupId,
  });

  factory LocalUserModel.fromLocalUser(LocalUser user) => LocalUserModel(
        uid: user.uid,
        email: user.email,
        fullName: user.fullName,
        points: user.points,
        bio: user.bio,
        enrolledCourseIds: user.enrolledCourseIds,
        profileImageUrl: user.profileImageUrl,
        followers: user.followers,
        following: user.following,
        groupId: user.groupId,
      );

  factory LocalUserModel.empty() => const LocalUserModel(
        uid: '',
        email: '',
        fullName: '',
        points: 0,
      );
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          points: (map['points'] as num).toInt(),
          bio: map['bio'] as String?,
          enrolledCourseIds:
              (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
          profileImageUrl: map['profileImageUrl'] as String?,
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          groupId: (map['groupId'] as List<dynamic>).cast<String>(),
        );

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    int? points,
    String? bio,
    List<String>? enrolledCourseIds,
    String? profileImageUrl,
    List<String>? followers,
    List<String>? following,
    List<String>? groupId,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      points: points ?? this.points,
      bio: bio ?? this.bio,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      groupId: groupId ?? this.groupId,
    );
  }

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'fullName': fullName,
        'points': points,
        'bio': bio,
        'enrolledCourseIds': enrolledCourseIds,
        'profileImageUrl': profileImageUrl,
        'followers': followers,
        'following': following,
        'groupId': groupId,
      };
}
