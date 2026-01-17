import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:almizan/views/choose_subject.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/views/auth/login.dart';
import 'package:almizan/widgets/swiper.dart';

class IntroTwoPage extends StatefulWidget {
  static const String path = "lib/src/pages/onboarding/intro2.dart";

  const IntroTwoPage({super.key});
  @override
  _IntroTwoPageState createState() => _IntroTwoPageState();
}

class _IntroTwoPageState extends State<IntroTwoPage> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = [
    "التطبيق الحصري والوحيد في مركز الميزان"
        " \n للتدريب والتأهيل الاقتصادي \n\n\n\n   جميع الحقوق محفوظة  \u00a92025 ",
    "مركز الميزان  \n طريقك نحو التميز الاقتصادي \n ",
    "مركز الميزان  \n ميزان المعرفة والنجاح\n   "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                  child: Swiper(
                index: _currentIndex,
                controller: _swiperController,
                itemCount: _pageCount,
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                loop: false,
                itemBuilder: (context, index) {
                  return _buildPage(
                      title: titles[index],
                      icon: "assets/img/bg.jpg",
                      index: index);
                },
                pagination: SwiperPagination(
                    builder: CustomPaginationBuilder(
                        activeSize: const Size(10.0, 20.0),
                        size: const Size(10.0, 15.0),
                        color: Colors.grey.shade600)),
              )),
              const SizedBox(height: 10.0),
              _buildButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
            ),
            child: const Text("Skip"),
            onPressed: () async {
              CacheHelper.saveData(key: "isNew", value: false);

              var token = await CacheHelper.getData(key: 'api_token');
              if (token != null) {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: ChooseSubject(),
                        duration: const Duration(microseconds: 800)));
              } else {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const Login(),
                        duration: const Duration(microseconds: 800)));
              }
            },
          ),
          IconButton(
            icon: Icon(
              _currentIndex < _pageCount - 1
                  ? FontAwesomeIcons.circleArrowRight
                  : FontAwesomeIcons.circleCheck,
              size: 40,
            ),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1) {
                _swiperController.next();
              } else {
                CacheHelper.saveData(key: "isNew", value: false);

                var token = await CacheHelper.getData(key: 'api_token');
                if (token != null) {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: ChooseSubject(),
                          duration: const Duration(microseconds: 800)));
                } else {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: const Login(),
                          duration: const Duration(microseconds: 800)));
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String icon, index}) {
    const TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(50.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
              image: AssetImage(icon),
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black38, BlendMode.multiply)),
          boxShadow: const [
            BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(5.0, 5.0),
                color: Colors.black26)
          ]),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/img/logo_app.png",
                fit: BoxFit.contain,
                width: 75,
              ),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/golden.png",
                  width: 150,
                )),
            if (index == 0)
              Text(
                "يرحب بكم ..",
                textDirection: TextDirection.rtl,
                style: titleStyle.copyWith(color: Colors.white),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),
            Text(
              title,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: titleStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
