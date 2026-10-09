import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نور القلوب',
      theme: ThemeData.dark(),
      home: QuranHome(),
    );
  }
}

class QuranHome extends StatefulWidget {
  @override
  _QuranHomeState createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome> {
  final player = AudioPlayer();
  int currentAya = 1;
  int currentSura = 1;
  bool isPlaying = false;

  // تشغيل آية ورة آية
  Future<void> playAya(int sura, int aya) async {
    try {
      // صوت الشيخ مشاري العفاسي
      final url = "https://everyayah.com/data/Alafasy_128kbps/${sura.toString().padLeft(3, '0')}${aya.toString().padLeft(3, '0')}.mp3";
      await player.setUrl(url);
      await player.play();
      setState(() {
        isPlaying = true;
        currentAya = aya;
        currentSura = sura;
      });
      
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          // شغل الآية الي وراها تلقائيا
          playAya(sura, aya + 1);
        }
      });
    } catch (e) {
      print("خطأ: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("القرآن الكريم - نور القلوب", style: TextStyle(color: Color(0xFFD4AF37))),
        iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // === الاهداء للمرحوم ناصر عزيز ===
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF111111),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Color(0xFFD4AF37), width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 19, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ثواب هذا العمل مهدى إلى روح المرحوم",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  Text(
                    "ناصر عزيز",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.5),
                  ),
                  Text(
                    "الفاتحة لروحه الطاهرة",
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16),
                  ),
                  Divider(color: Color(0xFFD4AF37).withOpacity(0.3), height: 20),
                  Text(
                    "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1) الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُد