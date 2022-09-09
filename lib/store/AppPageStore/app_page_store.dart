import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mert_karakis_web/firebase_configurations.dart';
import 'package:mert_karakis_web/global.dart';
import 'package:mert_karakis_web/model/AppPageModel/app_page_model.dart';
import 'package:mert_karakis_web/model/PageModel/page_model.dart';
import 'package:mobx/mobx.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
part 'app_page_store.g.dart';

class AppPageStore = _AppPageStoreBase with _$AppPageStore;

abstract class _AppPageStoreBase with Store {
  @observable
  AppPageModel appPageModel = const AppPageModel();

  @action
  void setAppPageModel(AppPageModel appPage) {
    appPageModel = appPage;
    print("setAppPageModel : ${appPageModel.toJson()}");
    print("setAppPageModel technologies : ${appPageModel.technologies}");
  }

  Map<String, PageModel> pageModels = {};

  @action
  Future<void> getPageModels() async {
    await FirebaseFirestore.instance.collection('apps').get().then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = value.docs;
      if (docs.isNotEmpty) {
        docs.forEach((element) {
          Map<String, dynamic> json = element.data();
          PageModel pageModel = PageModel.fromJson(json);

          pageModels.addAll({element.id: pageModel});
          if (element.id == "aboutMe") {
            appPageModel = pageModel.appPageModel!;
          }
        });
      }
    });
  }

  Future<List<String?>> setPhotos(String applicationName) async {
    ListResult photos =
        await FirebaseStorage.instanceFor(bucket: Configurations.storageBucket)
            .ref("$applicationName/photos")
            .listAll();
    List<String?> photosDownloadLink = [];
    for (Reference element in photos.items) {
      photosDownloadLink.add(await element.getDownloadURL());
    }
    return photosDownloadLink;
  }

  YoutubePlayerController? youtubePlayerController;

  void setYoutubePlayerController() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: appPageModel.videos!.toList().first,
      params: const YoutubePlayerParams(
        enableCaption: false,
        showControls: false,
        showFullscreenButton: false,
        showVideoAnnotations: false,
        autoPlay: true,
      ),
    );
  }
}
