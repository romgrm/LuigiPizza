import 'package:flutter/material.dart';
import '../router/Router.dart' as router;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // User swiped Left
        } else if (details.primaryVelocity! < 0) {
          // User swiped Right
          Navigator.pushNamed(context, router.mapScreen);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff856CD4),
        body: Center(
          child: Container(
              // color: Colors.yellow,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                  child: Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     shape: BoxShape.circle, color: Colors.yellow),
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/cheffull.png'),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: const Text(
                  "Luigi's Pizza",
                  style: TextStyle(
                      fontFamily: 'Title', fontSize: 50, color: Colors.white),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
