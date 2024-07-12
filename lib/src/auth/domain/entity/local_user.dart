import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    required this.groupId,
    required this.enrolledCourseIds,
    required this.following,
    required this.followers,
    this.profileImageUrl,
    this.bio,
  });

  factory LocalUser.empty() => const LocalUser(
        uid: '',
        email: '',
        points: 0,
        fullName: '',
        groupId: [],
        enrolledCourseIds: [],
        following: [],
        followers: [],
        bio: '',
        profileImageUrl: '',
      );

  final String uid;
  final String email;
  final String? profileImageUrl;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  bool? get stringify => true;

  @override
  String toString() =>
      'LocalUser { uid: $uid, email: $email, fullName $fullName }';
}
