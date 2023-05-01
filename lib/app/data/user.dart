import 'package:sales/constants/enums.dart';

class User {
  final String txID;
  final String userName;
  final String cId;
  final Role authorization;
  final String department;
  const User(
      {required this.cId,
      required this.txID,
      required this.userName,
      this.authorization = Role.sales,
      required this.department});

  User copyWith(
      {String? cId,
      String? txID,
      String? userName,
      String? department,
      Role? authorization}) {
    return User(
        cId: cId ?? this.cId,
        txID: txID ?? this.txID,
        userName: userName ?? this.userName,
        department: department ?? this.department,
        authorization: authorization ?? this.authorization);
  }
}
