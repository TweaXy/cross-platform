import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';
import 'package:http_parser/http_parser.dart';

class EditProfile {
  final String _editProfileEndpoint = 'users/';
  final String _removeProfilePictureEndpoint = 'profilePicture';
  final String _removeProfileBannerEndpoint = 'profileBanner';
  EditProfile._();
  static final instance = EditProfile._();
  Future<User>? future;
  // Future<void> excute(String id) async {
  //   future = getUserById(id);
  // }

  Future<void> editProfile({
    required User user,
    required Uint8List? newAvatar,
    required Uint8List? newBanner,
    required bool removedAvatar,
    required bool removedBanner,
    @required String? token,
  }) async {
    FormData formData;
    Map<String, dynamic> data = {
      'name': user.name,
      'birthdayDate': user.birthdayDate,
      'bio': user.bio ?? '',
      'website': user.website ?? '',
      'location': user.location ?? '',
    };
    if (removedAvatar && newAvatar == null) {
      try {
        await Api.delete(
            url: baseURL + _editProfileEndpoint + _removeProfilePictureEndpoint,
            body: {},
            token: token);
      } catch (e) {
        print('Avatar Exception :- ' + e.toString());
      }
    }

    if (newAvatar != null && !removedAvatar) {
      data.addEntries({
        'avatar': MultipartFile.fromBytes(newAvatar.toList(),
            contentType: MediaType('image', 'png'), filename: 'avatar.png')
      }.entries);
    }
    if (removedBanner && newBanner == null) {
      try {
        await Api.delete(
            url: baseURL + _editProfileEndpoint + _removeProfileBannerEndpoint,
            body: {},
            token: token);
      } catch (e) {
        print('Cover Exception :- ' + e.toString());
      }
    }
    if (newBanner != null && !removedBanner) {
      data.addEntries({
        'cover': MultipartFile.fromBytes(newBanner.toList(),
            contentType: MediaType('image', 'png'), filename: 'cover.png')
      }.entries);
    }
    formData = FormData.fromMap(data);
    await Api.patch(
      url: baseURL + _editProfileEndpoint,
      body: formData,
      token: token,
    );
  }
}
