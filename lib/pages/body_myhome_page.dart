import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/article_topic.dart';
import 'package:speaking_english_model_app/pages/topic_page.dart';
import 'package:speaking_english_model_app/pages/topics.dart';

class body_myHomePage extends StatelessWidget {
  const body_myHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                  
              backgroundColor: const Color(0xFFF1F1F1),                   
              elevation: 0,
              title: Image.asset('lib/img/logo_brand_color.png'),
              leading: IconButton(
                onPressed: (){},
                icon: Image.asset('lib/img/nav_bar.png'),
              ),
                
            ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30,right: 20,left: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Welcome,'),
                          Text('Timmy',
                              style: TextStyle(
                                color: Color(0xFFF83759),
                                fontSize: 24
                              ),
                            ),
                        ]
                      ),
                      Icon(Icons.person_rounded),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  height: 260,
                  
                  
                  child: Image.asset('lib/img/img_slide_english_0.png')
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  // color: Colors.grey,
                  decoration: const BoxDecoration(
                    
                    border:  Border(
                        bottom: BorderSide( //                   <--- left side
                        color: Colors.black,
                        width: 1.0,
                      )
                  ),
                  ),
                  child: const Text('Topics',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFF83759),
                    ),
                  )
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: ListView.builder(
                    itemCount: topic.length,
                    itemBuilder:(context,index)=> article_topic(topic: topic[index])                                               
                    // children: items.map((item) => CardBody(item: item)).toList(),   
                  ),
                ),
                
              ],
            ),
          ),
    );
  }
}