// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'MenuItem.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemName,
    itemPfp,
  ];

  static const List<MenuItem> profileItems = [
    itemCamera,
    itemGallery,
  ];

  static const itemName = MenuItem(
    text: "Edit name",
    icon: Icons.perm_identity,
  );

  static const itemPfp = MenuItem(
    text: "Edit profile picture",
    icon: Icons.face,
  );

  static const itemCamera = MenuItem(
    text: "Take photo",
    icon: Icons.photo_camera,
  );

  static const itemGallery = MenuItem(
    text: "Choose photo",
    icon: Icons.collections_outlined,
  );
}
