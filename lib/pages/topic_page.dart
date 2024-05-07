import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/article_topic.dart';
import 'package:speaking_english_model_app/pages/my_home_page.dart';
import 'package:speaking_english_model_app/pages/topics.dart';

class topic_widget extends StatefulWidget {
  const topic_widget({super.key});

  @override
  State<topic_widget> createState() => _topic_widgetState();
}

class _topic_widgetState extends State<topic_widget> {

  int _selectedIndex=0;

  final List<Widget> _widgetOptions=[
    const MyHomePage(),
    const topic_widget(),
    Text('User'),
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                  
        backgroundColor: const Color(0xFFF1F1F1),                   
        elevation: 0,
        title: Text('Topics'),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back_ios_new),
        ),      
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Xử lý khi nút "add" được nhấn
            },
          ),
        ],      
      ),
      body: Container(
          height: 700,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: ListView.builder(
            itemCount: topic.length,
            itemBuilder:(context,index)=> article_topic(topic: topic[index])                                               
            // children: items.map((item) => CardBody(item: item)).toList(),   
          ),
        ),
        
    );
  }
}