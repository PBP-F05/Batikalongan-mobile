import 'package:flutter/material.dart';
import 'package:batikalongan_mobile/article/artikel_screen.dart';  
import 'package:batikalongan_mobile/gallery/screens/gallery_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Eksplorasi Motif Khas",
      "description":
          "Jelajahi beragam motif batik Pekalongan dan temukan cerita di balik keindahannya.",
      "backgroundImage": "assets/images/onboarding1.png", 
    },
    {
      "title": "Panduan Toko Batik",
      "description":
          "Temukan informasi lengkap toko batik dan koleksi khas yang mereka tawarkan.",
      "backgroundImage": "assets/images/onboarding2.png", 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Menambahkan SafeArea untuk mencegah overflow
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xFFD88E30), Color(0xFFAF6200)],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Membatasi tinggi gambar dengan Container
                        Container(
                          width: double.infinity,
                          height: 500,  // Tinggi gambar yang terbatas
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(data['backgroundImage']!), 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 55),
                        // Gunakan Expanded untuk memastikan konten tidak overflow
                        Expanded(
                          child: SingleChildScrollView(  // Membungkus dalam SingleChildScrollView
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data['title']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontFamily: 'Fabled',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    data['description']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Membungkus dengan GestureDetector
                                GestureDetector(
                                  onTap: () {
                                    if (_currentPage == 1) {
                                      // Navigasi ke halaman artikel jika di halaman kedua
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GalleryScreen(),
                                        ),
                                      );
                                    } else {
                                      // Pindah ke halaman berikutnya
                                      if (_currentPage < onboardingData.length - 1) {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF774E1A),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20, // Mengubah nilai bottom untuk menghindari overflow
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(onboardingData.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
