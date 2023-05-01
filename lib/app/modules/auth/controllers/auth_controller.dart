import 'package:aveo_api/aveo_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/data/log_out_response.dart';
import 'package:sales/app/data/login_response.dart';
import 'package:sales/app/data/user.dart';
import 'package:sales/app/modules/auth/interceptor/interceptor.dart';
import 'package:sales/app/modules/auth/repository/auth_repository.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/enums.dart';
import 'package:sales/constants/message_type.dart';
import 'package:sales/utils/get_storage.dart';
import 'package:sales/core/snack_bar.dart';

class AuthController extends GetxController {
  static final AuthController to = Get.find<AuthController>();
  GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: 'auth form');
  GlobalKey<FormState> registerFormKey =
      GlobalKey<FormState>(debugLabel: 'auth form');
  String username = '';
  String password = '';
  Rx<User?> user = Rx(null);
  // Rx<Role?> role = Rx(null);
  // String department = '';
  final String rebuildSubCategory = 'rebuildSubCategory';

  @override
  void onInit() {
    _handelUser();
    AveoApiInterceptors.dio!.interceptors.add(RupiyaAuthInterceptor());
    super.onInit();
  }

  void _handelUser() {
    if (Storage.read(UserFields.txID.name) != null) {
      try {
        user.value = User(
          cId: Storage.read(UserFields.cID.name),
          txID: Storage.read(UserFields.txID.name),
          userName: Storage.read(
            UserFields.userName.name,
          ),
          authorization:
              Role.fromString(Storage.read(UserFields.authorization.name)),
          department: Storage.read(UserFields.department.name),
        );
      } catch (_) {
        user.value = null;
        Storage.deleteAll();
        Get.offAllNamed(Routes.AUTH);
      }
    }
  }

  void login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      AuthRepository.login(
        username: username,
        password: password,
        onSuccess: (code, res) {
          try {
            LoginResponse data = LoginResponse.fromJson(res);
            List<String> roleList = data.data!.first.role!.split(' ');
            String department = roleList.first;
            Role role = Role.fromString(roleList.last);

            user.value = User(
                cId: data.data!.first.cId!,
                txID: data.data!.first.trxId!,
                userName: username,
                authorization: role,
                department: department);
            if (role == Role.nan) {
              logOut();
            }
            Storage.write(UserFields.userName.name, user.value!.userName);
            Storage.write(UserFields.cID.name, user.value!.cId);
            Storage.write(UserFields.txID.name, user.value!.txID);
            Storage.write(UserFields.department.name, user.value!.department);
            Storage.write(
                UserFields.authorization.name, user.value!.authorization.name);
            Get.offAllNamed(Routes.HOME);
            invokeSnackBar(message: data.msg!);
          } catch (e) {
            invokeSnackBar(
                message: 'Something went wrong', type: SnackBarType.error);
          }
        },
        onError: (statusCode, data) {
          invokeSnackBar(
              message: data['msg'] ?? data['message'],
              type: SnackBarType.error);
        },
      ).then((value) => null);
    }
  }

  void logOut() async {
    AuthRepository.logout(
      user: user.value!,
      onSuccess: (code, res) {
        try {
          LogOutResponse data = LogOutResponse.fromJson(res);
          if (data.errorCode == 200) {
            user.value = null;
            Storage.deleteAll();
            Get.offAllNamed(Routes.AUTH);
          }
        } catch (e) {
          invokeSnackBar(
              message: 'Something went wrong', type: SnackBarType.error);
        }
      },
      onError: (statusCode, data) => invokeSnackBar(
          message: data['msg'] ?? data['message'], type: SnackBarType.error),
    );
  }
}
