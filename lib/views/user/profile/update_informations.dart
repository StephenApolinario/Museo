import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/user/update_informations.dart';
import 'package:museo/views/user/profile/components/update/address_data.dart';
import 'package:museo/views/user/profile/components/update/personal_data.dart';

class UpdateInformationView extends StatefulWidget {
  const UpdateInformationView({super.key});

  @override
  State<UpdateInformationView> createState() => _UpdateInformationViewState();
}

class _UpdateInformationViewState extends State<UpdateInformationView> {
  late PageController pageController;
  int currentPage = 0;

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
    List<UpdateInformationTitle> updateSteps =
        createUpdateInformationSteps(context: context);

    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.update_information,
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
          itemCount: updateSteps.length,
          onPageChanged: (value) => setState(() {
            currentPage++;
          }),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, step) {
            switch (step) {
              case 0:
                return UpdatePersonalData(
                  updatingTitleSubtitle: updateSteps[step],
                  pageController: pageController,
                );
              case 1:
                return UpdateAddressData(
                  registerTitleSubtitle: updateSteps[step],
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
