import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _nameState();
}

class _nameState extends State<UserProfile> {
  //sign usr out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(
                  246, 233, 222, 163), //fromARGB(255, 240, 193, 193),
              border: Border.all(
                color: Colors.grey.shade100,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 4)]),
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 80),
              CircleAvatar(
                backgroundColor: Colors.grey.shade500,
                radius: 80,
                child: Icon(
                  Icons.person_2_rounded,
                  color: Colors.blue.shade300,
                  size: 120,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  children: [
                    //settings button
                    MUIOutlinedBlockButton(
                      text: 'settings',
                      onPressed: () {},
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //logout button
                    MUIOutlinedBlockButton(
                      text: 'logout',
                      onPressed: () {
                        signUserOut();
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //user current subscription plan
                    MUIPricingCard(
                        title: 'Plan',
                        duration: MUIPricingDuration.monthly,
                        currency: MUIPricingCurrency.dollar,
                        amount: 5.99,
                        button: Column(
                          children: [
                            //MUICheckBox(onChanged: Colors.black, child: Text('24/7 access'), checked: checked),
                            MUIOutlinedButton(
                              text: 'Upgrade',
                              onPressed: () {},
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
