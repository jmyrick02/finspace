import 'package:finspace/Homepage/home.dart';
import 'package:finspace/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
}

enum Year { freshman, sophomore, junior, senior }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return const MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  TextEditingController nameController = TextEditingController();
  Year? classYear = Year.freshman;
  bool truthVal = true;
  var schoolValue;
  var foodValue;
  var creditHoursValue;
  var yearValue;
  var campusValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: IntroductionScreen(
          onDone: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('name', nameController.text);
            prefs.setString('classYear', yearValue.toString());
            prefs.setString('school', schoolValue.toString());
            prefs.setString('food', foodValue.toString());
            prefs.setString('creditHours', creditHoursValue.toString());
            prefs.setString('housing', campusValue.toString());
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Home(),
            ));
          },
          pages: [
            PageViewModel(
              title: "Hello! Welcome to Fin\$pace",
              body:
                  "Let's get started with the necessary information!\n\n Make sure to fill them all out",
              image: Center(
                child: Image.asset("assets/logo.png"),
              ),
              decoration: PageDecoration(
                titleTextStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                bodyTextStyle:
                    const TextStyle(fontSize: 20, color: Colors.black),
                descriptionPadding:
                    const EdgeInsets.all(16).copyWith(bottom: 0),
                imagePadding: const EdgeInsets.all(24),
                pageColor: Colors.white,
              ),
            ),
            PageViewModel(
              title: "Basic Info",
              bodyWidget: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: IntrinsicWidth(
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 90,
                                  maxWidth: 90,
                                ),
                                child: TextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.clip,
                                      fontSize: 20,
                                      color: Colors.black),
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    hintText: "Type here",
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              "Year",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: yearValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  yearValue = newValue;
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
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: Text(
                              "School",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: schoolValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  schoolValue = newValue;
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
                                          color: Colors.black, fontSize: 20)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "College Information",
              bodyWidget: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "Housing",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: campusValue,
                              isDense: false,
                              onChanged: (String? newValue) {
                                setState(() {
                                  campusValue = newValue;
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
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: Text(
                              "Food",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: foodValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  foodValue = newValue;
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
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "Credit Hours",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: creditHoursValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  creditHoursValue = newValue;
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
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "And we are done!",
              body: "Click Done to start saving :P",
              decoration: getPageDecoration(),
            ),
          ],
          onChange: (int index) {
            FocusManager.instance.primaryFocus?.unfocus();

            if (nameController.text.isNotEmpty && schoolValue != null) {
              if (campusValue != null &&
                  foodValue != null &&
                  creditHoursValue != null) {
                setState(() {
                  truthVal = true;
                });
              }
            } else {
              setState(() {
                truthVal = false;
              });
            }
          },
          showDoneButton: truthVal,
          color: Colors.black,
          globalBackgroundColor: Colors.white,
          showSkipButton: false,
          skipFlex: 0,
          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          next: const Icon(Icons.arrow_forward, color: Colors.blueAccent),
          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.easeIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Color(0xFFBDBDBD),
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        bodyTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
