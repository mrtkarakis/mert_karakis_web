import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mert_karakis_web/global.dart';
import 'package:mert_karakis_web/model/AppPageModel/app_page_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_page.dart';

class PhoneCase extends StatelessWidget {
  const PhoneCase({Key? key}) : super(key: key);

  // This isMobile, isTablet, isDesktop helep us later
  static bool isFull(BuildContext context) =>
      MediaQuery.of(context).size.height > 785;

  static const double width = 372;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        // if (isFull(context)) {
        return Container(
            width: width,
            height: 750,
            padding: EdgeInsets.symmetric(vertical: 65, horizontal: 30),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/phone_case.png'),
              ),
            ),
            child: GridView.builder(
                itemCount: AppType.values.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return linkButton(AppType.values[index]);
                })
            //  Column(
            //   children: [
            //     Row(
            //       children: [
            //         linkButton(LinkType.github),
            //         linkButton(LinkType.medium),
            //         linkButton(LinkType.linkedin),
            //         linkButton(LinkType.github),
            //       ],
            //     )
            //   ],
            // ),
            );
        // } else
        //   return Container();
      },
    );
  }

  TextButton linkButton(AppType appType) {
    double size = 86;
    Size minimumSize = Size(size, size);
    return TextButton(
      onPressed: appType.isPage
          ? () {
              bool isSetPage = false;
              appPageStore.pageModels.values.forEach((element) {
                if (!isSetPage &&
                    appType.name.toLowerCase() ==
                        element.title!.toLowerCase()) {
                  appPageStore.setAppPageModel(element.appPageModel!);
                  if (element.appPageModel?.videos?.isNotEmpty ?? false) {
                    appPageStore.setYoutubePlayerController();
                  }
                  isSetPage = true;
                }
              });
              if (!isSetPage) {
                AppPageModel appPageModel = AppPageModel(title: appType.title);
                appPageStore.setAppPageModel(appPageModel);
              }
            }
          : () => appType.title.toLowerCase() == 'mail'
              ? launchUrl(Uri(
                  scheme: 'mailto',
                  path: 'mekonyum1@gmail.com',
                  query:
                      'subject=App Feedback&body=App Version 3.23', //add subject and body here
                ))
              : launchUrl(
                  Uri.parse(
                    appType.url,
                  ),
                  mode: LaunchMode.platformDefault,
                ),
      style: TextButton.styleFrom(
          minimumSize: minimumSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/${appType.iconPath}.png',
            height: 30,
          ),
          FittedBox(child: Text(appType.title)),
        ],
      ),
    );
  }
}

enum AppType {
  github('GitHub', 'https://github.com/mrtkarakis', 'github', false),
  linkedin('LinkedIn', 'https://www.linkedin.com/in/mert-karakis/', 'linkedin',
      false),
  medium('Medium', 'https://medium.com/@mrtkarakis', 'medium', false),
  mail('Mail', 'https://medium.com/@mrtkarakis', 'mail', false),
  contacts('Contacts', 'https://medium.com/@mrtkarakis', 'contacts', true),
  aboutMe('About Me', 'https://medium.com/@mrtkarakis', 'about_me', true),
  technologies(
      'Technologies', 'https://medium.com/@mrtkarakis', 'technologies', true),
  tokenGo('Token Go', 'https://medium.com/@mrtkarakis', 'token_go_logo', true),
  cmonHealth('Cmon Health', 'https://medium.com/@mrtkarakis',
      'cmon_health_logo', true),
  cryptory('Cryptory', 'https://medium.com/@mrtkarakis', 'cryptory_logo', true),
  slothy('Slothy', 'https://medium.com/@mrtkarakis', 'slothy_logo', true),
  requestJob('Request Job', 'https://medium.com/@mrtkarakis', 'add', true);

  final String title;
  final String url;
  final String iconPath;
  final bool isPage;
  const AppType(this.title, this.url, this.iconPath, this.isPage);
  String fullPath() => "assets/icons/$iconPath.png";
}
