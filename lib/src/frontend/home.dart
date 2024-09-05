import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserProfile()));
  }

  void goToSignOutPage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignOutPage()));
  }

  //open a file
  void openFile(PlatformFile file) {
    //set linuxByProcess to false and linuxUsegio to true
    OpenFile.open(file.path, linuxByProcess: false, linuxUseGio: true);
  }

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
                        child: const Icon(Icons.close),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffff6961),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.red.shade300])),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 219, 201),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: goToSignOutPage,
      ),
      drawerEnableOpenDragGesture: true,
      body: Container(
        color: const Color.fromARGB(255, 233, 219, 201),
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(
                        Icons.person_2_rounded,
                        color: Colors.blue.shade300,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Good day Daniel,",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.red.shade400,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: const Text(
                    "let us get started",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 40),
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
                  image: const Icon(Icons.upload_file_rounded),
                ),
                const SizedBox(height: 20),
                const MUISimpleCard(
                    title: "Follow us!", description: "description"),
                const SizedBox(height: 20),
                Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xffffb347),
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
    return SizedBox(
      width: 80,
      height: 60,
      child: LottieBuilder.asset("assets/app_assets/upload.json"),
    );
  }
}
