

import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/article_topic.dart';
import 'package:speaking_english_model_app/pages/body_myhome_page.dart';
import 'package:speaking_english_model_app/pages/topic_page.dart';
import 'package:speaking_english_model_app/pages/topics.dart';
// ignore: depend_on_referenced_packages, library_prefixes
// import 'package:audio/app_colors.dart' as AppColors;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _selectedIndex=0;
  int id=0;
  final List<Widget> _widgetOptions=[
    const body_myHomePage(),
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
    return Container(
      color:const Color(0xFFF83759),
      child: SafeArea(
        child: Scaffold( 
          
                        
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFF1F1F1),
            items:const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded),
                label: 'Topics'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'User'
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFF83759),
            onTap: _onItemTap,
          ),    
        ),
      ),
    );
  }
}