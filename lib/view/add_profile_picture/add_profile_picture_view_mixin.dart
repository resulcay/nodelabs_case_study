import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/network/base_config/api_call_mixin.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/network/manager/auth_manager.dart';
import 'package:nodelabs_case_study/view/add_profile_picture/add_profile_picture.dart';

mixin AddProfilePictureViewMixin on State<AddProfilePictureView> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  AuthManager authManager = AuthManager(
    authRepository: AuthRepository(DioManager().client),
  );

  @override
  void dispose() {
    selectedImage = null;
    super.dispose();
  }

  Future<void> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = File(image.path));
    }
  }

  void removeImage() {
    setState(() => selectedImage = null);
  }

  Future<void> uploadImage() async {
    if (selectedImage == null) return;

    try {
      setState(() => isLoading = true);

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(selectedImage!.path),
      });

      final response = await authManager.uploadPhoto(formData: formData);
      if (response != null) {
        showCustomSnackBar(
          LocaleKeys.pages_add_profile_photo_success.tr(),
          type: SnackbarType.success,
        );
        await userCredentialViewModel.updateUserProfile(
          photoUrl: response.data?.photoUrl,
        );
        selectedImage = null;
        setState(() => isLoading = false);
        if (mounted) {
          context.router.back();
        }
      } else {
        showCustomSnackBar(
          LocaleKeys.pages_add_profile_photo_error_occurred.tr(),
          type: SnackbarType.error,
        );
      }
    } on ErrorResponseException catch (err) {
      showCustomSnackBar(
        err.error.displayMessage.isNotEmpty
            ? err.error.displayMessage
            : LocaleKeys.pages_add_profile_photo_error_occurred.tr(),
        type: SnackbarType.error,
      );
    } on Exception catch (_) {
      setState(() {
        isLoading = false;
        selectedImage = null;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget circleIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.black54,
      radius: 16,
      child: IconButton(
        icon: Icon(icon, size: 16, color: Colors.white),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}
