import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:finspace/settings/MenuItem.dart';
import 'package:finspace/settings/MenuItems.dart';
import 'package:finspace/settings/camera/camera.dart';
import 'package:finspace/settings/camera/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings(
      {Key? key,
      required name,
      required year,
      required major,
      required housing,
      required food,
      required creditHours})
      : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? name;
  String? year;
  String? major;
  String? housing;
  String? food;
  String? creditHours;
  bool isExpanded = false;
  UniqueKey yearTile = UniqueKey();
  UniqueKey majorTile = UniqueKey();
  UniqueKey housingTile = UniqueKey();
  UniqueKey foodTile = UniqueKey();
  UniqueKey creditHoursTile = UniqueKey();
  TextEditingController nameController = TextEditingController();

  void shrinkYearTile() {
    setState(() {
      yearTile = UniqueKey();
      isExpanded = false;
    });
  }

  void shrinkMajorTile() {
    setState(() {
      majorTile = UniqueKey();
      isExpanded = false;
    });
  }

  void shrinkHousingTile() {
    setState(() {
      housingTile = UniqueKey();
      isExpanded = false;
    });
  }

  void shrinkFoodTile() {
    setState(() {
      foodTile = UniqueKey();
      isExpanded = false;
    });
  }

  void shrinkCreditHoursTile() {
    setState(() {
      creditHoursTile = UniqueKey();
      isExpanded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      year = prefs.getString("classYear");
      major = prefs.getString("school");
      housing = prefs.getString("housing");
      food = prefs.getString("food");
      creditHours = prefs.getString("creditHours");
    });
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.blueAccent,
                  child: ListTile(
                    title: Text(
                      name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("./assets/me.PNG"),
                    ),
                    trailing: PopupMenuButton<MenuItem>(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        ...MenuItems.itemsFirst.map(buildItem).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        key: yearTile,
                        initiallyExpanded: isExpanded,
                        leading: const Icon(
                          FontAwesomeIcons.hashtag,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          "Year: " + year.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                "Edit Year: ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              DropdownButton<String>(
                                value: year,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    year = newValue;
                                  });
                                },
                                items: [
                                  "Freshman",
                                  "Sophomore",
                                  "Junior",
                                  "Senior",
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  shrinkYearTile();
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      _borderAroundTile(),
                      ExpansionTile(
                        key: majorTile,
                        initiallyExpanded: isExpanded,
                        leading: const Icon(
                          FontAwesomeIcons.hashtag,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          "Major: " + major.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                "Edit Major: ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              DropdownButton<String>(
                                value: major,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    major = newValue;
                                  });
                                },
                                items: [
                                  "AH",
                                  "ATEC",
                                  "BBS",
                                  "EPPS",
                                  "ECS",
                                  "IS",
                                  "JSOM",
                                  "NSM",
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17)),
                                  );
                                }).toList(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  shrinkMajorTile();
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      _borderAroundTile(),
                      ExpansionTile(
                        key: housingTile,
                        initiallyExpanded: isExpanded,
                        leading: const Icon(
                          FontAwesomeIcons.hashtag,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          "Housing: " + housing.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                "Edit Housing: ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              DropdownButton<String>(
                                value: housing,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    housing = newValue;
                                  });
                                },
                                items: [
                                  "UV",
                                  "Res Hall",
                                  "Northside",
                                  "Commuter",
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17)),
                                  );
                                }).toList(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  shrinkHousingTile();
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      _borderAroundTile(),
                      ExpansionTile(
                        key: foodTile,
                        initiallyExpanded: isExpanded,
                        leading: const Icon(
                          FontAwesomeIcons.hashtag,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          "Food: " + food.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                "Edit Food: ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              DropdownButton<String>(
                                value: food,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    food = newValue;
                                  });
                                },
                                items: [
                                  "Comet 10",
                                  "Comet 14",
                                  "Comet 19",
                                  "Block 15",
                                  "Block 30",
                                  "Block 50",
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17)),
                                  );
                                }).toList(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  shrinkFoodTile();
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      _borderAroundTile(),
                      ExpansionTile(
                        key: creditHoursTile,
                        initiallyExpanded: isExpanded,
                        leading: const Icon(
                          FontAwesomeIcons.hashtag,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          "Credit Hours: " + creditHours.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                "Edit Credit Hours: ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              DropdownButton<String>(
                                value: creditHours,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    creditHours = newValue;
                                  });
                                },
                                items: [
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                  "5",
                                  "6",
                                  "7",
                                  "8",
                                  "9",
                                  "10",
                                  "11",
                                  "12",
                                  "13",
                                  "14",
                                  "15",
                                  "16",
                                  "17",
                                  "18",
                                  "19"
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17)),
                                  );
                                }).toList(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  shrinkCreditHoursTile();
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      _borderAroundTile(),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                const Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                ),
                SwitchListTile(
                  activeColor: Colors.blueAccent,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: const Text(
                    "Allow notifications",
                  ),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Colors.blueAccent,
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: const Text(
                    "Allow notifications related to financial advice",
                  ),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Colors.blueAccent,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: const Text(
                    "Allow app updates notifications",
                  ),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Colors.blueAccent,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: const Text(
                    "Allow notifications regarding transcations",
                  ),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _borderAroundTile() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade500,
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemName:
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Edit name"),
                content: TextField(
                  controller: nameController,
                ),
                actions: [
                  MaterialButton(
                    elevation: 5,
                    child: const Text("Done",
                        style: TextStyle(color: Colors.blueAccent)),
                    onPressed: () async {
                      setState(() {
                        name = nameController.text;
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              );
            });
        break;
      case MenuItems.itemPfp:
        showModalBottomSheet(
          context: context,
          builder: ((builder) => bottomSheet()),
        );
        // PopupMenuButton<MenuItem>(
        //   onSelected: (item) => onSelected(context, item),
        //   itemBuilder: (context) => [
        //     ...MenuItems.profileItems.map(buildItem).toList(),
        //   ],
        // );
        break;
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {},
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                GalleryScreen(images: []);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _imageFile = pickedFile;
  //   });
  // }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            const SizedBox(width: 12),
            Text(item.text),
          ],
        ),
      );
}
