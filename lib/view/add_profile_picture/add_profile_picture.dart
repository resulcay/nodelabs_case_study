import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/product/common/primary_button.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/view/add_profile_picture/add_profile_picture_view_mixin.dart';

@RoutePage()
class AddProfilePictureView extends StatefulWidget {
  const AddProfilePictureView({super.key});

  @override
  State<AddProfilePictureView> createState() => _AddProfilePictureViewState();
}

class _AddProfilePictureViewState extends State<AddProfilePictureView>
    with AddProfilePictureViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withValues(alpha: .2)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => context.router.back(),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          LocaleKeys.pages_add_profile_photo_title.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                LocaleKeys.pages_add_profile_photo_add_photo.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                '''Resources out incentivize relaxation floor loss cc.''',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.withValues(alpha: .2)),
                ),
                child: selectedImage == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: pickImage,
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Row(
                                children: [
                                  circleIconButton(
                                    icon: Icons.edit,
                                    onPressed: pickImage,
                                  ),
                                  const SizedBox(width: 8),
                                  circleIconButton(
                                    icon: Icons.delete,
                                    onPressed: removeImage,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const Spacer(),
              PrimaryButton(
                isLoading: isLoading,
                onPressed: uploadImage,
                text: LocaleKeys.pages_add_profile_photo_continue.tr(),
                loadingText: LocaleKeys.pages_add_profile_photo_loading.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
