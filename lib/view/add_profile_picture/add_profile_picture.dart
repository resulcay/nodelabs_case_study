import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/product/common/primary_button.dart';
import 'package:nodelabs_case_study/view/add_profile_picture/add_profile_picture_view_mixin.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<ThemeViewModel, ThemeState>(
          builder: (context, themeState) {
            return Scaffold(
              backgroundColor: themeState.isDark ? Colors.black : Colors.white,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor:
                    themeState.isDark ? Colors.black : Colors.white,
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: .2)),
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
                title: Text(
                  'Profil Detayı',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Fotoğraflarınızı Yükleyin',
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
                      border:
                          Border.all(color: Colors.grey.withValues(alpha: .2)),
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
                    text: 'Devam Et',
                    loadingText: 'Kaydediliyor...',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
