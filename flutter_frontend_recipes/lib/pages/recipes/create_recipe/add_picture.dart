import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'create_recipe_progress.dart';
import 'create_recipe_title.dart';

enum ImageType { gallery, camera }

class AddPicture extends StatefulWidget {
  final Function(String picture) setPicture;
  final Function() next;
  final Function() back;

  const AddPicture({
    Key? key,
    required this.setPicture,
    required this.next,
    required this.back,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  var _image;
  var imagePicker;
  String path = "";

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          widget.back();
        });
        return Future.value(false);
      },
      child: Material(
          child: Column(
        children: [
          Stack(children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.back();
                });
              },
              icon: Icon(
                Icons.arrow_back,
                size: 32,
                color: Theme.of(context).colorScheme.onSecondary,
                shadows: [Shadow(color: Colors.black, blurRadius: 1.0)],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Progress(total: 4, current: 4),
            ),
          ]),
          const RecipeTitle(name: "Wie sieht dein Gericht aus?"),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Füge jetzt ein Foto hinzu",
                  style: TextStyle(fontSize: 16),
                )),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.7),
                            spreadRadius: 10,
                            blurRadius: 100,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 120,
                      child: Material(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.pop(context);
                                chooseImage(ImageType.gallery);
                              },
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.collections,
                                      size: 28,
                                    ),
                                  ),
                                  Text(
                                    "Galerie",
                                    style: TextStyle(fontSize: 22),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1.5,
                              thickness: 1.5,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.pop(context);
                                chooseImage(ImageType.camera);
                              },
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 28,
                                    ),
                                  ),
                                  Text(
                                    "Kamera",
                                    style: TextStyle(fontSize: 22),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color(0xff66aa44),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            child: const Text("Foto auswählen"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  if (path == "")
                    path = "assets/example_pictures/standard_picture.jpg";
                  setState(() {
                    widget.setPicture(path);
                    widget.next();
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xff66aa44),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text("Nächster Schritt"),
              ),
            ),
          )
        ],
      )),
    );
  }

  void chooseImage(ImageType type) async {
    var source =
        (type == ImageType.camera) ? ImageSource.camera : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.rear);
    setState(() {
      _image = File(image.path);
      path = image.path;
    });
  }
}
