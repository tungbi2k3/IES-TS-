

import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/topic_detail_screen.dart';
import 'package:speaking_english_model_app/pages/topics.dart';
// ignore: camel_case_types
class article_topic extends StatelessWidget {
  final Topic topic;

  article_topic({super.key,required this.topic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      
      // color: Colors.grey,
      child: Container(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [                                                              
            Image.asset(topic.image),                              
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 200,
              height: 90,
              
                child: Column(                             
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text( topic.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                          ),
                        )
                    ),      
                    const SizedBox(height: 3,),                            
                    const Text('Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3
                    )
                  ],                
                ),
              ),
            
          ],
        ),
        
      ),
      onTap: (){ Navigator.push
          (context, MaterialPageRoute(
            builder: (context)=>TopicDetailScreen(topic: topic)
            )
          );
        }
    );
  }
}