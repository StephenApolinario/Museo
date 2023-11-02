import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/views/user/profile/components/build_profile_options.dart';
import 'package:museo/views/user/profile/components/quizzes/build_quizzes_perfomance.dart';
import 'package:museo/views/user/profile/components/build_top_profile_information.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.profile_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const BuildTopProfileInformations(),
            const BuildQuizzesPerfomance(),
            BuildProfileOptions(context: context),
          ],
        ),
      ),
    );
  }
}
