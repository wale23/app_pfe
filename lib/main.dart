import 'package:flutter/material.dart';
import 'Page1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'SignIn.dart';
import 'SignUp.dart';
import 'button.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}
class homePage extends StatelessWidget {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              Page1(
                "images/img_3.png",
                "Your app. in the palm of your hands",
                "Make agents more productive."    "Make managers more impactful."
                    "Make customers more empowered.",
                Colors.white,
              ),
              Page1(
                "images/img.png",
                "Work Modes",
                "Know which complaint requires your intervention at this time. GPRO Desk automatically organizes your complaints by due time or status type.",
                Colors.white,
              ),
              Page1(
                "images/img_1.png",
                "Conversation view ",
                "See the entire complaint conversation on a single screen.The latest response is desplayed on top, so you can cut right to the chase.",
                Colors.white,
              ),
              Page1(
                "images/img_2.png",
                "Dashboard view ",
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return signInemail();
                          }));
                    },
                    style: buttonPrimary,
                    child: const Text(
                      "Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),

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
                        "D'ont have an account? ",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => signUp()));
                        },
                        child: Text("Sign up",style: TextStyle(fontSize: 20,color: Colors.lightGreen,fontWeight: FontWeight.bold),),
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