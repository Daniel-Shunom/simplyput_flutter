import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:simplyputapp/src/components/my_drawer.dart';
import 'package:simplyputapp/src/frontend/profile_page.dart';
import 'package:simplyputapp/src/frontend/signout_page.dart';

/*void main() {
  runApp(const Home());
}*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context as BuildContext);

    //go to profile page
    Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) => UserProfile()));
  }

  void goToSignOutPage() {
    //pop menu drawer
    Navigator.pop(context as BuildContext);

    //go to profile page
    Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) => SignOutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
      ),
      backgroundColor: const Color.fromARGB(255, 179, 203, 255),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: goToSignOutPage,
      ),
      drawerEnableOpenDragGesture: true,
      body: Container(
        color: Color.fromARGB(255, 15, 31, 65),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          //BUTTONS
          child: Column(
            //MODIFY THE BUTOTNS HERE!!
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //ANIMATED SVG
              Expanded(
                  child: ListView(children: [
                const SizedBox(height: 60),
                MUIPrimaryCard(
                    title: "Files",
                    description: "",
                    buttons: [
                      MUIGradientButton(text: "Upload", onPressed: () {})
                    ],
                    image: Icon(Icons.upload_file_rounded)),
                const SizedBox(height: 20),
                MUISimpleCard(title: "Follow us!", description: "description"),
                const SizedBox(height: 20),
                Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffffb347),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffff6961),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(2, 2))
                        ])),
                const SizedBox(height: 20),
              ])),

              //Button Container
              /*Container(
                //INNER BUTTON CONTENTS
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 70,
                decoration: BoxDecoration(
                    color: Color(0xffffb347),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffff6961),
                        spreadRadius: 1,
                        blurRadius: 8,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("data"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("Upload"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("data"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20)*/
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      child: LottieBuilder.asset("assets/app_assets/upload.json"),
    );
  }
}
