import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
        child: Column(
          children: [
            Stack(
              // fit: StackFit.expand,
              children: [
                Blur(
                  blur: 0,
                  blurColor: Colors.black,
                  colorOpacity: 0.4,
                  overlay: SizedBox(
                    width: 60,
                    child: Image.asset(
                      'assets/images/add_photo.png',
                      color: Colors.white,
                    ),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://socialsizes.io/static/facebook-cover-photo-size-b4dd6123feb0ded4531a05cbd0bccd30.jpg',
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 5,
                          )),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
