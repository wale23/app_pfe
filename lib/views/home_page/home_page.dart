import 'package:app_pfe/views/auth/sign_in/SignIn.dart';
import 'package:app_pfe/views/auth/sign_up/SignUp.dart';
import 'package:app_pfe/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                "images/img_3.png",
                "Votre application. dans la paume de tes mains",
                "Rendre les agents plus productifs."
                    "Rendre les managers plus impactants."
                    "Rendre les clients plus autonomes.",
                Colors.white,
              ),
              Page1(
                "images/img.png",
                "Modes de travail",
                "Sachez quelle plainte nécessite votre intervention en ce moment. GPRO Desk organise automatiquement vos réclamations par date d'échéance ou par type de statut.",
                Colors.white,
              ),
              Page1(
                "images/img_1.png",
                "Affichage des conversations",
                "Visualisez l'intégralité de la conversation de plainte sur un seul écran. La dernière réponse est affichée en haut, vous pouvez donc aller droit au but.",
                Colors.white,
              ),
              Page1(
                "images/img_2.png",
                "Vue du tableau de bord",
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
            const SizedBox(height: 80.0),
            Image.asset(image),
            const SizedBox(
              height: 15,
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23.9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
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
