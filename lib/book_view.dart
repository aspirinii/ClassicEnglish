
import 'package:flutter/material.dart';
// import 'dart:ui';
import 'dart:async';
// import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; //rootbundle
import 'dart:convert';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Hide the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'froggggg',
//       home: MyHomePage(),
//     );
//   }
// }

class SentenceWidget extends StatelessWidget {
  SentenceWidget({Key? key, required this.model}) : super(key: key);

  Sentence model;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        GestureDetector(
          // onLongPress: () {
          onTap: () {
            model.changeActivation();
            print('taptap');
          },
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  // Color(0xFFA8AEAB),
                  Color(0xFFD4D5C8),
                  Color(0xFFD4D5C8),
                ]),
              ),
              child: Opacity(
                opacity: 1,
                child: Text(model.contentE,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Color(0xFF1B2F3A))),
              )),
        ),
        GestureDetector(
          onTap: () {
            model.changeActivation();
            print('taptap');
          },
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  // Color(0xFFA8AEAB),
                  Color(0xFFD4D5C8),
                  Color(0xFFD4D5C8),
                ]),
              ),
              child: Obx(() => AnimatedOpacity(
                  opacity: model.active.value ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: KoreanParagraph(model: model)))),
        ),
      ],
    );
  }
}

class KoreanParagraph extends StatelessWidget {
  KoreanParagraph({Key? key, required this.model}) : super(key: key);

  Sentence model;
  @override
  Widget build(BuildContext context) {
    if (model.active.value) {
      return Text(model.contentK,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Color(0xFF1B2F3A)));
    } else {
      return const SizedBox.shrink();
    }
  }
}

class Sentence extends GetxController {
  late int id;
  RxBool active = false.obs;
  late String contentK;
  late String contentE;

  Sentence(this.id, this.active, this.contentK, this.contentE);

  Sentence.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['index']);
    active.value = false;
    contentE = json['contentE'];
    contentK = json['contentK'];
  }

  changeActivation() {
    active.value = !active.value;
  }
}

class Controller extends GetxController {
  var dataFromJson;
  var listSentence;
  var map;
  late Future<dynamic> rawData;

  Future LoadDataJson() async {
    final _rawData = await rootBundle.loadString("assets/frog.json");

    List<Map<String, dynamic>> output =
        List.from(json.decode(_rawData) as List);

    print(output.runtimeType);

    return output;
  }

  @override
  onInit() {
    dataFromJson = LoadDataJson();
    // print(dataFromJson);
    print('onInit start');
  }
}

class BookView extends StatelessWidget {
  BookView({Key? key}) : super(key: key);

  // Generate a dummy list
  final Controller c = Get.put(Controller());
  // final List numbers = List.generate(30, (index) => "Item $index");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: c.dataFromJson,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            print("Snap : ${snap.data.runtimeType}");

            return Scaffold(
                backgroundColor: Color(0xFFD4D5C8),
                 //리스트뷰 사이에 보이는 컬러 ㅋㅋ
                appBar: AppBar(
                  backgroundColor: const Color(0xFF333D79),
                  title: Text(
                    snap.data[0]['contentE'],
                    style: const TextStyle(
                      color: Color(0xAAFAEBEF),
                    ),
                  ),
                ),
                // // Implement the GridView
                body:
                  ListView(children: [
                  for (var w in snap.data)
                    SentenceWidget(model: Sentence.fromJson(w)),
                ]));
          } else {
            // return const Text("Loading ");
            return Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [
                0.001,
                0.2,
                0.4,
              ],
              colors: [
                Colors.white,
                Colors.blue,
                Colors.black,
              ],
            )
          ),
          child: const Center(
            child: Text(
              'Learning with Classic',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
          }
        });
  }
}
