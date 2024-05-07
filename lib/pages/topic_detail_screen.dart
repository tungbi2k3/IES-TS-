import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/article_topic.dart';
import 'package:speaking_english_model_app/pages/body_myhome_page.dart';
import 'package:speaking_english_model_app/pages/topic_page.dart';
import 'package:speaking_english_model_app/pages/topics.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:speech_to_text/speech_to_text.dart';

import 'package:flutter_tts/flutter_tts.dart';

class TopicDetailScreen extends StatefulWidget {
  final Topic topic;
  const TopicDetailScreen({super.key,required this.topic});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

enum TtsState{playing, stopped} 

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  //Bien Text to SPeeach
  late FlutterTts _flutterTts;
  String _tts="";
  TtsState _ttsState =TtsState.stopped;
  //Bien SPeeach to Text
  final SpeechToText _speechToText=SpeechToText();
  bool _speechEnabled=false;
  String _wordsSpoken="";  
  double _confidenceLevel=0;
  List<List<dynamic>> data = [];
  int i=0;

  
  
  @override
  void initState(){
    super.initState();
    initTts();
    initSpeech();
    loadCsvData();
  }
 @override
  void dispose(){
    super.dispose();
    _flutterTts.stop();
  }

  initTts() async{
    _flutterTts=FlutterTts();

    await _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        _ttsState=TtsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        print('Complete');
        _ttsState=TtsState.stopped;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        print('Cancel');
        _ttsState=TtsState.stopped;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        print('Error: $message');
        _ttsState=TtsState.stopped;
      });
    });

  }
  // Goi cac ham Speech to Text
  void initSpeech() async{
    _speechEnabled = await _speechToText.initialize();
  }

  void _startListening() async{
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel=0;
    });
  }

  void _stopListening() async{
    await _speechToText.stop();
    setState(() {
      
    });
  }

  void _onSpeechResult(result){
    setState(() {
      _wordsSpoken="${result.recognizedWords}";
    });
  }

  Widget buttonplay() {
    if(_ttsState==TtsState.stopped){
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          backgroundColor: Color(0xFFF83759),
        ),
        onPressed: speak,
        icon: Icon(Icons.volume_up,color: Colors.white,), // Icon thay vì Text
        label: Text(
          '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }else{
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          backgroundColor: Color(0xFFF83759),
        ),
        onPressed: speak,
        icon: const Icon(Icons.volume_down,color: Colors.white,), // Icon thay vì Text
        label: const Text(
          '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }
  Future<void> loadCsvData() async {
    final String rawCsv = await rootBundle.loadString('lib/csv/book_0.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(rawCsv);
    setState(() {
      data = csvData;      
    });
  }
  Future speak() async {
   await _flutterTts.setLanguage("en-US");
   await _flutterTts.setVolume(1);
   await _flutterTts.setSpeechRate(0.5);
   await _flutterTts.setPitch(0.5);
   if (_tts != null) {
     if (_tts!.isNotEmpty) {
       await _flutterTts.speak(_tts!);
     }
   }
 }
  Future stop() async {
   var result = await _flutterTts.stop();
   if (result == 1) {
     setState(() {
       _ttsState = TtsState.stopped;
     });
   }
 }
  void changeData() {
    setState(() {
      // Tăng chỉ số lên 1 đơn vị
      i++;      
      // Nếu chỉ số vượt quá số lượng dòng trong dữ liệu, quay lại 0
      if (i >= data.length) {
        i = 0;
      }
      _tts=data[i][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> ttsWords = _tts!.toLowerCase().split(' '); // Chuyển đổi các từ thành chữ cái thường và tách chúng ra
    List<String> spokenWords = _wordsSpoken.toLowerCase().split(' '); // Chuyển đổi các từ thành chữ cái thường và tách chúng ra

    int matchingWordsCount = 0; // Đếm số từ giống nhau

    // Duyệt qua từng từ trong danh sách các từ đã nói
    for (int i = 0; i < spokenWords.length; i++) {
      String word = spokenWords[i];
      if (i < ttsWords.length && ttsWords[i] == word) { // Kiểm tra từ có trong danh sách _tts không
        matchingWordsCount++; // Nếu có, tăng biến đếm lên
      }
    }
    
    double similarityPercentage = (matchingWordsCount / spokenWords.length) * 100; // Tính phần trăm tương tự
    
    var score = StringSimilarity.compareTwoStrings(_tts, _wordsSpoken);
    double percentageScore = score * 100; // → 0.8

    bool isEqual = ttsWords.length == spokenWords.length;// So sánh length _tts và _wordsSpoken
    String comparisonResult ;
    if(similarityPercentage ==100){
      comparisonResult="Good job";
    }else if(similarityPercentage>70){
      comparisonResult="Great!";
    }else{
      comparisonResult="Try again!";
    }
    
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF83759),
          title: Text(widget.topic.title),          
        ),
        
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(25),
                child: Row(
                  children: [                    
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Màu viền
                          width: 1, // Độ dày của viền
                        ),
                        borderRadius: BorderRadius.circular(30), // Độ cong của góc viền
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Khoảng cách giữa nội dung và viền
                        child: Text(
                          data[i][0],
                          // Hiển thị kết quả so sánh
                          style: const TextStyle(
                            fontSize: 20,                            
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),                   
                    SizedBox(width: 10), // Khoảng trắng giữa TextField và button
                    buttonplay(),                    
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              
              
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Text(
                      _speechToText.isListening 
                        ? "Listening..." 
                        : _speechEnabled 
                          ? "Tap the microphone to start listening..." 
                          : "Speech not available",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _speechToText.isListening ? _stopListening : _startListening,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                      backgroundColor: Color(0xFFF83759),
                    ),
                    icon: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                    ),
                    label: Text(
                      _speechToText.isNotListening ? "Start Listening" : "Stop Listening",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),  
                    margin: EdgeInsets.symmetric(horizontal: 30),                  
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Màu nền của Container
                      borderRadius: BorderRadius.circular(10), // Độ cong của viền bo góc
                      border: Border.all(
                        color: Colors.grey, // Màu viền
                        width: 1, // Độ dày của viền
                      ),
                    ),
                    child: Text(
                      _wordsSpoken,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),                                            
                  ),
                  SizedBox(height: 20),
                  Text(
                    comparisonResult, // Hiển thị kết quả so sánh
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (similarityPercentage >= 70) ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'So sánh thông thường: ${similarityPercentage.toStringAsFixed(2)}%', // Hiển thị phần trăm tương tự với hai chữ số sau dấu thập phân
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 10),
                  Text(
                    'So sánh string-similarity: ${percentageScore.toStringAsFixed(2)}%', // Hiển thị phần trăm tương tự với hai chữ số sau dấu thập phân
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),
                    ),                    
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: changeData,
                style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      backgroundColor: Color(0xFFF83759),
                    ),
                child: Text('Next', style: 
                TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),), // Text hiển thị trên nút
              ),
            ],
          ),
        ),
      ),
    );
  }

}