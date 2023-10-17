import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/user/registering.dart';
import 'package:museo/views/user/registering/components/address_data.dart';
import 'package:museo/views/user/registering/components/password_data.dart';
import 'package:museo/views/user/registering/components/personal_data.dart';

class RegisteringView extends StatefulWidget {
  const RegisteringView({super.key});

  @override
  State<RegisteringView> createState() => _RegisteringViewState();
}

class _RegisteringViewState extends State<RegisteringView> {
  late PageController pageController;
  int currentPage = 0;

  // Address Data

  // Password Data
  late String? password, repeatedPassword;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<RegisteringTitleSubtitle> registerintSteps =
        createRegisteringSteps(context: context);

    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.registering_title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainBlue,
        leading: currentPage != 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentPage -= 2;
                  });
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView.builder(
          controller: pageController,
          itemCount: registerintSteps.length,
          onPageChanged: (value) => setState(() {
            currentPage++;
          }),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, step) {
            switch (step) {
              case 0:
                return RegisteringPersonalData(
                  registerTitleSubtitle: registerintSteps[step],
                  pageController: pageController,
                );
              case 1:
                return RegisteringAddressData(
                  registerTitleSubtitle: registerintSteps[step],
                  pageController: pageController,
                );
              case 2:
                return RegisteringPasswordData(
                  registerTitleSubtitle: registerintSteps[step],
                  pageController: pageController,
                );
            }
            return null;
          },
        ),
      ),
    );
  }
}
