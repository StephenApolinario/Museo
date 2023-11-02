import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:museo/constants/colors.dart' as custom_color;
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/helpers/loading_complete.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:museo/utilities/menu/menu_items.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: custom_color.mainBlue,
      child: Column(
        children: [
          header(context),
          menuItems(context),
          buttomLogos(),
        ],
      ),
    );
  }

  Padding buttomLogos() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Movi Logo
          Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final Uri url = Uri.parse(moviHome);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              // icon: const Icon(Icons.access_alarm), //Logo Movi Here
              icon: Image.asset(
                Assets.logos.movi.path,
                height: 40,
                width: 40,
              ),
            ),
          ),
          // Univali Logo
          Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final Uri url = Uri.parse(univaliHome);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              icon: Image.asset(
                Assets.logos.univali.path,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItems(BuildContext context) {
    final User userProvider = Provider.of<User>(context, listen: true);

    return Expanded(
      child: Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          menuItem(
            context: context,
            icon: Icons.house_outlined,
            title: context.loc.home,
            route: home,
          ),
          menuItem(
            context: context,
            icon: Icons.favorite,
            title: context.loc.favorite,
            onTapAction: () {
              if (userProvider.logged) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(favorites);
              } else {
                showGenericDialog(
                  context: context,
                  title: context.loc.dialog_error_ops,
                  content: context.loc.should_login,
                  optionsBuilder: () => {
                    'Ok': false,
                  },
                );
              }
            },
          ),
          // TODO:  Implement search option.
          // menuItem(
          //   context: context,
          //   icon: Icons.search,
          //   title: context.loc.search,
          //   route: search,
          // ),
          menuItem(
            context: context,
            icon: Icons.segment,
            title: context.loc.sections,
            route: sections,
          ),
          menuItem(
            context: context,
            icon: Icons.map,
            title: context.loc.localization,
            onTapAction: () {
              return openMapsSheet(context);
            },
          ),
          menuItem(
            context: context,
            icon: Icons.store,
            title: context.loc.souvenirs,
            onTapAction: () {
              if (userProvider.logged) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(souvernirsStore);
              } else {
                showGenericDialog(
                  context: context,
                  title: context.loc.dialog_error_ops,
                  content: context.loc.should_login,
                  optionsBuilder: () => {
                    'Ok': false,
                  },
                );
              }
            },
          ),
          menuItem(
            context: context,
            icon: Icons.airplane_ticket,
            title: context.loc.store,
            onTapAction: () {
              if (userProvider.logged) {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(ticketsStore);
              } else {
                showGenericDialog(
                  context: context,
                  title: context.loc.dialog_error_ops,
                  content: context.loc.should_login,
                  optionsBuilder: () => {
                    'Ok': false,
                  },
                );
              }
            },
          ),
          menuItem(
            context: context,
            icon: Icons.museum,
            title: context.loc.about_movi,
            route: aboutMovi,
          ),
          menuItem(
            context: context,
            icon: Icons.info,
            title: context.loc.about_application,
            route: aboutApplication,
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (userProvider.logged) {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(userProfile);
            } else {
              Navigator.of(context).pushNamed(login);
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                profilePicture(context),
              ],
            ),
          ),
        ),
        logginAndForgetPassword(context),
        logoutButton(context),
        divider(),
      ],
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.only(top: 0),
      child: Divider(
        thickness: 2,
        color: Colors.white,
      ),
    );
  }

  Widget profilePicture(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        radius: 52,
        backgroundImage: userProvider.logged &&
                userProvider.loggedUser.picture !=
                    'https://www.nopicture.com.br/' //TODO: In future, when the user upload an image, you must change this code.
            ? NetworkImage(userProvider.loggedUser.picture)
            : AssetImage(Assets.user.defaultProfilePicture.path)
                as ImageProvider,
        // NetworkImage(
        //     userProvider.logged ? userProvider.loggedUser.picture : ''),
      ),
    );
  }

  Widget logginAndForgetPassword(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);
    final navigator = Navigator.of(context);

    if (!userProvider.logged) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            child: Text(
              context.loc.login_or_register,
            ),
          ),
          TextButton(
            onPressed: () {
              navigator.pushNamed(userForgetPassword);
            },
            child: Text(
              context.loc.forget_password,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget logoutButton(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);
    final navigator = Navigator.of(context);

    if (userProvider.logged) {
      return Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
        child: InkWell(
          onTap: () async {
            userProvider.logOut();
            await loadingMessageTime(
              title: context.loc.leaving,
              subtitle: context.loc.redirecting,
              context: context,
            );
            navigator.pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Text(
                context.loc.logout,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

openMapsSheet(context) async {
  try {
    final coords = Coords(
      -26.754003,
      -48.687816,
    );
    const title = 'Museu Oceanográfico UNIVALI';
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: coords,
                      title: title,
                      description:
                          'Museu universitário com grande variedade de vida marinha e ênfase na fauna local.',
                    ),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    rethrow;
  }
}
