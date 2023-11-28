import 'dart:typed_data';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';
import 'package:tweaxy/components/custom_date_picker_style.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});
  final User user;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  CroppedFile? newBanner;
  CroppedFile? newAvatar;
  Uint8List? bannerByte;
  Uint8List? avatarByte;
  bool initialAvatar = true;
  bool initialBanner = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  bool initiallized = false;
  bool removedBanner = false;
  bool removedAvatar = false;
  User? user;
  String? initDate;
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwaGpoNGVkMDAwMHMxMTNjMTNtYTVmNFwiIiwiaWF0IjoxNzAxMTI3NjQyLCJleHAiOjE3MDM3MTk2NDJ9.GdpgNR9R6eCO1jjHduosoHHhBewb9QlXal5VX6g7i1s';
  @override
  Widget build(BuildContext context) {
    user = widget.user;

    if (!initiallized) {
      _nameController.text = user!.name!;
      _bioController.text = user!.bio ?? '';
      _websiteController.text = user!.website ?? '';
      _locationController.text = user!.location ?? '';
      initDate = user!.birthdayDate ?? '1974-03-20 00:00:00.000';
      _birthDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(initDate!));
      initiallized = true;
    }
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
                  onPressed: () async {
                    var tempUser = user!;
                    tempUser.name = _nameController.text;
                    tempUser.bio = _bioController.text;
                    tempUser.birthdayDate =
                        DateTime.parse(_birthDateController.text).toString();
                    tempUser.location = _locationController.text;
                    tempUser.website = _websiteController.text;
                    await EditProfile.instance.editProfile(
                        user: user!,
                        newAvatar: avatarByte,
                        newBanner: bannerByte,
                        removedAvatar: removedAvatar,
                        removedBanner: removedBanner,
                        token: token);
                    Navigator.pop(context);
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
                height: MediaQuery.of(context).size.height / 3.4,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AddImage(
                          initial: initialBanner,
                          image: bannerByte,
                          url: user!.cover ?? kDefaultBannerPhoto,
                          size: kIsWeb ? 90 : 50,
                          onPressed: () async {
                            if (!kIsWeb) {
                              _showPickDialog(
                                  context, true, 370, 194, CropStyle.rectangle);
                            } else {
                              var croppedImage = await pickAndCrop(
                                  ImageSource.gallery,
                                  500,
                                  185,
                                  CropStyle.rectangle,
                                  context);
                              setState(() {
                                if (croppedImage != null) {
                                  initialBanner = false;
                                  newBanner = croppedImage;
                                }
                              });
                            }
                          },
                          defaultBanner: true,
                          otherOnPressed: () {
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: kIsWeb ? 36 : 0,
                        )
                      ],
                    ),
                    Positioned(
                      top:
                          MediaQuery.of(context).size.height / (kIsWeb ? 7 : 5),
                      left: 15,
                      child: Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: ClipOval(
                          child: AddImage(
                            onPressed: () async {
                              if (!kIsWeb) {
                                _showPickDialog(
                                    context, false, 85, 85, CropStyle.circle);
                              } else {
                                var croppedImage = await pickAndCrop(
                                    ImageSource.gallery,
                                    kIsWeb ? 110 : 70,
                                    kIsWeb ? 110 : 70,
                                    CropStyle.circle,
                                    context);
                                setState(() {
                                  newAvatar = croppedImage;
                                });
                              }
                            },
                            image: avatarByte,
                            initial: initialAvatar,
                            url: removedAvatar
                                ? kDefaultAvatarPhoto
                                : basePhotosURL + user!.avatar!,
                            size: kIsWeb ? 52 : 30,
                            defaultBanner: false,
                          ),
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
              EditProfileTextField(
                controller: _bioController,
                labelText: 'Bio',
                minLines: 3,
                maxLines: 20,
              ),
              EditProfileTextField(
                  controller: _locationController,
                  labelText: 'Location',
                  minLines: 1,
                  maxLines: 1),
              EditProfileTextField(
                  controller: _websiteController,
                  labelText: 'Website',
                  minLines: 1,
                  maxLines: 1),
              EditProfileTextField(
                  readOnly: true,
                  controller: _birthDateController,
                  labelText: 'Birth Date',
                  minLines: 1,
                  maxLines: 1),
              CustomDatePicker(
                setBirthDate: _setBirthDate,
                initialDate: DateTime.parse(initDate!),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setBirthDate(DateTime newDateTime) {
    setState(() {
      _birthDateController.text = newDateTime.toString().split(' ')[0];
    });
  }

  Future<dynamic> _showPickDialog(BuildContext context, bool banner,
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
                  if (!banner) {
                    newAvatar = image;
                    initialAvatar = false;
                    avatarByte = await newAvatar!.readAsBytes();
                    removedAvatar = false;
                  } else {
                    newBanner = image;
                    initialBanner = false;
                    bannerByte = await newBanner!.readAsBytes();
                    removedBanner = false;
                  }
                  setState(() {});
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
                  if (!banner) {
                    newAvatar = image;
                    initialAvatar = false;
                    avatarByte = await newAvatar!.readAsBytes();
                    removedAvatar = false;
                  } else {
                    if (image != null) {
                      newBanner = image;
                      initialBanner = false;
                      bannerByte = await newBanner!.readAsBytes();
                      removedBanner = false;
                    }
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
                title: const Text('Choose existing photo'),
              ),
              removedBanner
                  ? ListTile(
                      onTap: () {
                        newBanner = null;
                        initialBanner = true;
                        user!.cover = null;
                        removedBanner = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: const Text('Remove header'),
                    )
                  : const SizedBox(),
              banner
                  ? ListTile(
                      onTap: () {
                        newBanner = null;
                        initialBanner = true;
                        user!.cover = null;
                        removedBanner = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: const Text('Remove Cover Image'),
                    )
                  : ListTile(
                      onTap: () {
                        removedAvatar = true;
                        newAvatar = null;
                        initialAvatar = true;
                        user!.cover = null;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: const Text('Remove Avatar Image'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  EditProfileTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.minLines,
    required this.maxLines,
    this.readOnly = false,
    this.focusNode,
  });
  final String labelText;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final bool readOnly;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      child: TextFormField(
        readOnly: readOnly,
        focusNode: focusNode,
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
            hideBottomControls: false,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            showCropGrid: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
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
    required this.image,
    required this.defaultBanner,
    required this.initial,
    this.otherOnPressed,
  });
  final bool initial;
  final String url;
  final double size;
  final Function() onPressed;
  final Uint8List? image;
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
          child: initial || image == null
              ? CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: url,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image.memory(image!),
        ));
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
