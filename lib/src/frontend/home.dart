import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:open_file/open_file.dart';
import 'package:simplyputapp/src/backend/image_cropper.dart';
import 'package:simplyputapp/src/components/my_drawer.dart';
import 'package:simplyputapp/src/components/recognition_page.dart';
import 'package:simplyputapp/src/frontend/profile_page.dart';
import 'package:simplyputapp/src/frontend/signout_page.dart';
import 'package:simplyputapp/src/backend/doc_pickers.dart';

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

  //open a file
  void openFile(PlatformFile file) {
    //set linuxByProcess to false and linuxUsegio to true
    OpenFile.open(file.path, linuxByProcess: false, linuxUseGio: true);
  }

  @override
  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context,
          {VoidCallback? onCameraTap, VoidCallback? onChooseFileTap}) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        child: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                MUIGradientBlockButton(
                    text: "Camera",
                    onPressed: () {
                      pickImage().then((value) {
                        if (value != '') {
                          imgCropperView(value, context).then((value) {
                            if (value != '') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RecognizePage(
                                            imgpath: value,
                                          )));
                            }
                          });
                        }
                      });
                    }),
                const SizedBox(height: 20),
                MUIOutlinedBlockButton(
                    text: "choose files",
                    onPressed: () async {
                      pickFiles().then((value) {
                        if (value != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      RecognizePage(imgpath: value)));
                        }
                      });
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

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
                      MUIGradientButton(
                          text: "Upload",
                          onPressed: () {
                            _showUploadSheet(context);
                          })
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
