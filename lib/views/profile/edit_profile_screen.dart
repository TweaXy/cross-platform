import 'dart:io';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? newBannerPath;
  String? newAvatarPath;
  final Function() onSavePressed = () {
    // TODO: Save changes to database and update profile info in app state
  };

  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text('Edit Profile'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          kIsWeb
              ? Center(
                  child: ElevatedButton(
                    key: const ValueKey('editScreenSaveChangesWeb'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                )
              : TextButton(
                  key: const ValueKey('editScreenSaveChangesMobile'),
                  onPressed: () {
                    //TODO: Upload your updates
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AddImage(
                          key: const ValueKey('editScreenBanner'),
                          path: newBannerPath,
                          url:
                              'https://socialsizes.io/static/facebook-cover-photo-size-b4dd6123feb0ded4531a05cbd0bccd30.jpg',
                          size: kIsWeb ? 90 : 60,
                          onPressed: () async {
                            if (!kIsWeb) {
                              _showPickDialog(context, false, 370, 141,
                                  CropStyle.rectangle);
                            } else {
                              var croppedImage = await pickAndCrop(
                                  ImageSource.gallery,
                                  !kIsWeb ? 370 : 500,
                                  !kIsWeb ? 141 : 185,
                                  CropStyle.rectangle,
                                  context);
                              setState(() {
                                newBannerPath = croppedImage!.path;
                              });
                            }
                          },
                          defaultBanner: true,
                          otherOnPressed: () {
                            setState(() {
                              newBannerPath = 'asset';
                            });
                          },
                        ),
                        const SizedBox(
                          height: kIsWeb ? 36 : 50,
                        )
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height /
                          (kIsWeb ? 7 : 6.7),
                      left: 15,
                      child: CircleAvatar(
                        key: const ValueKey('editScreenAvatar'),
                        radius: kIsWeb ? 60 : 40,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: AddImage(
                                onPressed: () async {
                                  if (!kIsWeb) {
                                    _showPickDialog(context, false, 70, 70,
                                        CropStyle.rectangle);
                                  } else {
                                    var croppedImage = await pickAndCrop(
                                        ImageSource.gallery,
                                        kIsWeb ? 110 : 70,
                                        kIsWeb ? 110 : 70,
                                        CropStyle.circle,
                                        context);
                                    setState(() {
                                      newAvatarPath = croppedImage!.path;
                                    });
                                  }
                                },
                                path: newAvatarPath,
                                url:
                                    'https://www.gstatic.com/webp/gallery2/4.png',
                                size: kIsWeb ? 52 : 40,
                                defaultBanner: false,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: TextFormField(
                  key: const ValueKey('nameTextFormField'),
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Name cannot be blank',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    labelText: 'Name',
                    labelStyle:
                        TextStyle(color: Colors.grey[700], fontSize: 18),
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: TextFormField(
                  key: const ValueKey('bioTextFormField'),
                  controller: _bioController,
                  minLines: 3,
                  maxLines: 20,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle:
                        TextStyle(color: Colors.grey[700], fontSize: 18),
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: TextFormField(
                  key: const ValueKey('locationTextFormField'),
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle:
                        TextStyle(color: Colors.grey[700], fontSize: 18),
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              //TODO:- Add Date Picker Here in this TextFormField
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: TextFormField(
                  key: const ValueKey('birthTextFormField'),
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Birth date',
                    labelStyle:
                        TextStyle(color: Colors.grey[700], fontSize: 18),
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showPickDialog(BuildContext context, bool remove,
      double scaleX, double scaleY, CropStyle cropStyle) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  var image = await pickAndCrop(
                    ImageSource.camera,
                    scaleX,
                    scaleY,
                    cropStyle,
                    context,
                  );
                  setState(() {
                    if (remove) {
                      newAvatarPath = image?.path;
                    } else {
                      newBannerPath = image?.path;
                    }
                  });
                  Navigator.of(context);
                },
                title: const Text('Take photo'),
              ),
              ListTile(
                onTap: () async {
                  var image = await pickAndCrop(
                    ImageSource.gallery,
                    scaleX,
                    scaleY,
                    cropStyle,
                    context,
                  );
                  Navigator.pop(context);
                  setState(() {
                    if (remove) {
                      newAvatarPath = image?.path;
                    } else {
                      newBannerPath = image?.path;
                    }
                  });
                },
                title: const Text('Choose existing photo'),
              ),
              !remove
                  ? ListTile(
                      onTap: () {
                        setState(() {
                          newBannerPath = 'asset';
                        });
                        Navigator.pop(context);
                      },
                      title: const Text('Remove header'),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<CroppedFile?> pickAndCrop(ImageSource imageSource, double ratioX,
    double ratioY, CropStyle cropStyle, BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(
    source: imageSource,
  );
  if (photo != null) {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: photo.path,
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      cropStyle: cropStyle,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Move and scale',
            hideBottomControls: true,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            showCropGrid: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        WebUiSettings(
          context: context,
          viewPort: CroppieViewPort(
            width: ratioX.toInt(),
            height: ratioY.toInt(),
          ),
          enforceBoundary: true,
          mouseWheelZoom: true,
        ),
      ],
    );
    return croppedFile;
  } else {
    throw ('Photo is null');
  }
}

class AddImage extends StatelessWidget {
  AddImage({
    super.key,
    required this.url,
    required this.size,
    required this.onPressed,
    required this.path,
    required this.defaultBanner,
    this.otherOnPressed,
  });
  final String url;
  final double size;
  final Function() onPressed;
  final String? path;
  final bool defaultBanner;
  Function()? otherOnPressed = () {};
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: kIsWeb && defaultBanner ? () {} : onPressed,
      child: Blur(
          blur: 0,
          blurColor: Colors.black,
          colorOpacity: kIsWeb ? 0.2 : 0.4,
          overlay: SizedBox(
            width: size,
            child: kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PickupPhotoWeb(
                        onPressed: onPressed,
                      ),
                      defaultBanner
                          ? ProfileIconButton(
                              icon: Icons.close,
                              onPressed: otherOnPressed!,
                              color: Colors.black.withOpacity(0.5),
                              iconColor: Colors.white,
                              borderWidth: 0)
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  )
                : Image.asset(
                    'assets/images/add_photo.png',
                    color: Colors.white,
                  ),
          ),
          child: path == null
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: url,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 5,
                        )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : path != 'asset'
                  ? Image.network(
                      path!,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/default_banner.png',
                      height: 166,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )),
    );
  }
}

class PickupPhotoWeb extends StatelessWidget {
  const PickupPhotoWeb({
    super.key,
    required this.onPressed,
  });
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            'assets/images/add_photo.png',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
