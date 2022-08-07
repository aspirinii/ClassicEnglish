import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'book_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'where is it used ?',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Map> _products = List.generate(
  //     100,
  //     (index) => {
  //           "id": index,
  //           "name": "Product $index",
  //           "price": Random().nextInt(100)
  //         }).toList();
  final List<Map> _bookList = [
    { 
      "id" : "1",
      "name" : "어린왕자",
      "subtitle" : "the little prince",
    },
    { 
      "id" : "2",
      "name" : "1984",
      "subtitle" : "1984",
    },
    {
      "id" : "3",
      "name" : "개구리 왕자",
      "subtitle" : "Frog King",

    }
  ];

  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English And Korean Classic Novel'),
        
      ),
      body: 
          Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              PlutoMenuBar(
                menus: [
                  PlutoMenuItem(
                    icon: Icons.star,
                    title: "Favorite",
                    onTap: () => message(context, 'star'),
                  ),
                  PlutoMenuItem(
                    icon: Icons.bedroom_baby,
                    title: 'Level 0',
                    onTap: () => message(context, 'baby'),
                  ),
                  PlutoMenuItem(
                    icon : Icons.school,
                    title: 'Level1',
                    onTap: () => message(context, 'school'),
                  ),
                  PlutoMenuItem(
                    icon : Icons.stacked_bar_chart,
                    title: 'Level2',
                    onTap: () => message(context, 'design'),
                  ),
                ],
              ),
              const SizedBox(
              height: 3,
              ),
              Flexible(
              child: Container(
                // padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    padding: const EdgeInsets.all(30),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40),
                    itemCount: _bookList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: (){
                            message(context, _bookList[index]['name']);
                            Get.to(BookView());

                          },
                        child: GridTile(
                          key: ValueKey(_bookList[index]['id']),
                        
                            child: Image.network(
                              'https://blogfiles.pstatic.net/MjAyMjA3MDlfMTg3/MDAxNjU3MzQzNDU5MTMy.l5aLSBEiDIyUqst-en2YNW7OOSwCLAua2eyxb2a0Onwg.iUjzBZdNSqTDyYxmejZkSmIZ3kKX5Deb7GPJof0CKUcg.PNG.aspirinii/bookBrown.png',
                              fit: BoxFit.cover,
                            ),
                          header:Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.fromLTRB(20, 10, 10, 10), 
                                child: Text(
                                    _bookList[index]['subtitle'],
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold
                                        ,color: Colors.white),
                                  ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.fromLTRB(20, 0, 10, 10), 
                                child: Text(
                                    _bookList[index]['name'],
                                    style: const TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.bold
                                        ,color: Colors.grey),
                                  ),
                              ),
                            ],
                          ), 
                          
                          // GridTileBar(
                          //   backgroundColor: Colors.black54.withAlpha(0),
                          //   title: Text(
                          //     _bookList[index]['subtitle'],
                          //     style: const TextStyle(
                          //         fontSize: 10, fontWeight: FontWeight.bold),
                          //   ),
                          //   subtitle: Text(
                          //     _bookList[index]['subtitle'],
                          //     style : const TextStyle( fontSize: 10)
                      
                          //   ),
                            
                          //   // trailing: const Icon(
                          //   //   Icons.star,
                          //   //   size : 13
                          //   //   ),
                          // ),
                        ),
                      );
                    }),
              ),
            ),
            ]
          ),

    );
  }
  

}
