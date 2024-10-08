import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/common/widgets/short_bar.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp/features/auth/pages/image_picker.dart';
import 'package:whatsapp/features/auth/widgets/custom_text_field.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key,this.profileImageUrl});

  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController userNameCotroller;

  saveUserDataToFirestore() async {
    String userName = userNameCotroller.text;
    if (userName.isEmpty) {
      return showAlertDialog(context: context, message: 'No value');
    } else if (userName.length < 3 || userName.length > 20) {
      return showAlertDialog(
          context: context, message: 'userName must be between 3 and 20');
    }
    ref.read(authControllerProvider).saveUserInfoToFirestore(
        userName: userName,
        profileImage: imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
        context: context,
        mounted: mounted);
  }

  imagePickerbottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortBar(),
              Row(children: [
                const SizedBox(width: 20),
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                custom_icon_button(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 17),
              ]),
              Divider(
                color: context.theme.greyColor!.withOpacity(0.3),
              ),
              const SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  imagePickerIcon(
                      onTap: pickImageFromCamera,
                      icon: Icons.camera_alt_rounded,
                      text: 'Camera'),
                  const SizedBox(
                    width: 15,
                  ),
                  imagePickerIcon(
                      onTap: () async {
                        Navigator.pop(context);
                        final image = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ImagePickers()));
                        if (image == null) return;
                        setState(() {
                          imageGallery = image;
                          imageCamera = null;
                        });
                      },
                      icon: Icons.photo_camera_back_rounded,
                      text: 'Gallery'),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        });
  }

  pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(
        context: context,
        message: e.toString(),
      );
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        custom_icon_button(
          onTap: onTap,
          icon: icon,
          minWidth: 50,
          border: Border.all(
              color: context.theme.greyColor!.withOpacity(0.2), width: 1),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        )
      ],
    );
  }

  @override
  void initState() {
    userNameCotroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Profile Info',
            style: TextStyle(color: context.theme.authAppbarTextColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Please provide your name and an optional profile photo',
                  style: TextStyle(
                    color: context.theme.greyColor,
                  )),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: imagePickerbottomSheet,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.photoIconBgColor,
                      border: Border.all(
                        color: imageCamera == null && imageGallery == null
                            ? Colors.transparent
                            : context.theme.greyColor!.withOpacity(0.4),
                      ),
                      image: imageCamera != null || imageGallery != null || widget.profileImageUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: imageGallery != null
                                  ? MemoryImage(imageGallery!) as ImageProvider
                                  : widget.profileImageUrl != null ? NetworkImage(widget.profileImageUrl!) : FileImage(imageCamera!) as ImageProvider,
                            )
                          : null),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: imageCamera == null && imageGallery == null && widget.profileImageUrl == null
                          ? context.theme.photoIconColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      controller: userNameCotroller,
                      textAlign: TextAlign.left,
                      autoFocus: true,
                      hintText: 'Type your name here',
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: context.theme.photoIconColor,
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: custom_elevated_button(
            onPressed: saveUserDataToFirestore, text: 'Next', buttonWidth: 90));
  }
}
