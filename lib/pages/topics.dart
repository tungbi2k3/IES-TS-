import 'package:flutter/material.dart';

class Topic{
  final String image, title, description;
  final int id;
  Topic({
      required this.id,
      required this.image,
      required this.title,
      required this.description
  });
}

List<Topic> topic=[
  Topic(
    id:1,
    title: "Education",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png",
    
  ),
  Topic(
    id:2,
    title: "Conversation",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
  Topic(
    id:3,
    title: "Dating",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
  Topic(
    id:4,
    title: "Sport",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
  Topic(
    id:5,
    title: "Holiday",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
  Topic(
    id:6,
    title: "Chatting",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
  Topic(
    id:7,
    title: "Homework",
    description: "Exploring common scenarios in academic settings from classroom discussions to parent-teacher conferences and study challenges.",
    image: "lib/img/imgtopic_1.png"
  ),
];