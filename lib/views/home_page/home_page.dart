import 'package:app_pfe/views/auth/sign_in/SignIn.dart';
import 'package:app_pfe/views/auth/sign_up/SignUp.dart';
import 'package:app_pfe/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../ressources/dimensions/constants.dart';

class HomePage extends StatelessWidget {
  PageController _controller = PageController();
  void markaAsSeen() {
    GetStorage().write("seen", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              Page1(
                "images/Message.json",
                "Your App. In the palm of your hands",
                "Make agents more productive."
                    "Make managers more impactful."
                    "Make customers more empowered.",
                Colors.white,
              ),
              Page1(
                "images/Complaint.json",
                "Work Modes",
                "Know which complaints need your attention right now. GPRO desk automatically organizes your complaints by due time or priority type.",
                Colors.white,
              ),
              Page1(
                "images/Wechat.json",
                "Conversation View",
                "See the entire complaints conversation on a single screen. The latest response is desplayed on top,so you can cut right to the chase.",
                Colors.white,
              ),
              Page1(
                "images/Data Analysis.json",
                "Dashboard View",
                "",
                Colors.white,
              ),
            ],
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      markaAsSeen();
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return SignIn();
                      }));
                    },
                    style: buttonPrimary,
                    child: const Text(
                      "S'identifier",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Divider(
                    color: Colors.grey,
                    height: 3,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas de compte?",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {
                          markaAsSeen();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 20, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1(
    this.image,
    this.heading,
    this.text,
    this.color, {
    super.key,
  });
  final String image;
  final String heading;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset(image,),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.2,
                fontSize: 21,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
