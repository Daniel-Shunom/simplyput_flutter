import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:profile/profile.dart';

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
        title: const Text('S I M P L Y  P U T'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
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
              const Icon(
                Icons.person,
                size: 200,
              ),
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
