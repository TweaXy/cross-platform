import 'dart:io';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker picker = ImagePicker();
  String? newBannerPath;
  String? newAvatarPath;

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
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
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
          TextButton(
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
                height: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AddImage(
                          path: newBannerPath,
                          url:
                              'https://socialsizes.io/static/facebook-cover-photo-size-b4dd6123feb0ded4531a05cbd0bccd30.jpg',
                          size: 60,
                          onPressed: () {
                            _showPickDialog(
                                context, false, 370, 141, CropStyle.rectangle);
                          },
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6.7,
                      left: 15,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: AddImage(
                                onPressed: () {
                                  _showPickDialog(
                                      context, true, 70, 70, CropStyle.circle);
                                },
                                path: newAvatarPath,
                                url:
                                    'https://www.gstatic.com/webp/gallery3/5.png',
                                size: 40,
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
                  var image = await _pickAndCrop(
                    ImageSource.camera,
                    scaleX,
                    scaleY,
                    cropStyle,
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
                  var image = await _pickAndCrop(
                    ImageSource.gallery,
                    scaleX,
                    scaleY,
                    cropStyle,
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

  Future<CroppedFile?> _pickAndCrop(ImageSource imageSource, double ratioX,
      double ratioY, CropStyle cropStyle) async {
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
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      return croppedFile;
    } else {
      throw ('Photo is null');
    }
  }
}

class AddImage extends StatelessWidget {
  const AddImage({
    super.key,
    required this.url,
    required this.size,
    required this.onPressed,
    required this.path,
  });
  final String url;
  final double size;
  final Function() onPressed;
  final String? path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Blur(
          blur: 0,
          blurColor: Colors.black,
          colorOpacity: 0.4,
          overlay: SizedBox(
            width: size,
            child: Image.asset(
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
                  ? Image.file(
                      File(path!),
                      fit: BoxFit.cover,
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
