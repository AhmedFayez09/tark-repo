import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final dio = Dio();
  List? data;
  void getDataFromApi() async {
    await dio.get("https://fakestoreapi.com/products").then((value) {
      data = value.data;
    });
    // log("${data?[1]["title"]}");
  }

  void getCourse() async {
    await dio.get("http://192.168.1.3:5000/api/courses/").then((value) {
      log("in function get courses : $value");
    });
  }

  void postCourse() async {
    await dio.post(
      "http://192.168.1.3:5000/api/courses/",
      data: {"name" : "flutter course3"},
    ).then((value) {
      log("in post course function : success post");
    });
  }
  void getOneCourse(){
    
  }

  @override
  void initState() {
    super.initState();
    getDataFromApi();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [IconButton(onPressed: () {
            getCourse();
          }, icon: Icon(Icons.access_alarm_outlined))],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: postCourse,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              color: Colors.grey[300],
              child: Center(child: Text("${data?[index]["title"]}")),
            );
          },
        ));
  
  
  
  
  }
}
