import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';

class ImagePickers extends StatefulWidget {
  const ImagePickers({super.key});

  @override
  State<ImagePickers> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickers> {
  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;
  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent < .33) return;
    if (currentPage == lastPage) return;
    fetchAllImages();
  }

  fetchAllImages() async {
    lastPage = currentPage;

    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    List<AssetEntity> photos =
        await albums[0].getAssetListPaged(page: currentPage, size: 24);
    List<Widget> temp = [];

    for (var asset in photos) {
      temp.add(
        FutureBuilder<Uint8List?>(
            future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRect(
                  child: InkWell(
                    onTap: () => Navigator.pop(context, snapshot.data),
                    borderRadius: BorderRadius.circular(5),
                    splashFactory: NoSplash.splashFactory,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: context.theme.greyColor!.withOpacity(0.4),
                            width: 1),
                        image: DecorationImage(
                          image: MemoryImage(snapshot.data as Uint8List),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
      );
    }
    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: custom_icon_button(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),
        title: Text(
          'Whatsapp',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        actions: [
          custom_icon_button(
            onTap: () {},
            icon: Icons.more_vert,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: NotificationListener(
          onNotification: (ScrollNotification scroll) {
            handleScrollEvent(scroll);
            return true;
          },
          child: GridView.builder(
              itemCount: imageList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (_, index) {
                return imageList[index];
              }),
        ),
      ),
    );
  }
}
