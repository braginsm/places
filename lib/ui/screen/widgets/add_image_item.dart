import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/data/blocks/add_place/add_place_state.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';

class AddImageItem extends StatefulWidget {
  final String img;
  final AddPlaceBloc bloc;
  const AddImageItem({Key? key, required this.img, required this.bloc})
      : super(key: key);

  @override
  _AddImageItemState createState() => _AddImageItemState();
}

class _AddImageItemState extends State<AddImageItem> {
   Future<void> _picImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      List<String> _list = [];
      _list.addAll((widget.bloc.state as AddPlaceLoadingSuccessState).images);
      _list.add(image.path);
      widget.bloc.add(AddPlaceAddImageEvent(_list));
    }
  }

  void _showAddPhoto() {
    showDialog(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          //color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _picImage(ImageSource.camera),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SvgPicture.asset(ImagesPaths.camera),
                            ),
                            const Text("????????????"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _picImage(ImageSource.gallery),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SvgPicture.asset(ImagesPaths.photo),
                            ),
                            const Text("????????????????????"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _picImage(ImageSource.gallery),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SvgPicture.asset(ImagesPaths.file),
                            ),
                            const Text("????????"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "????????????",
                      style: TextStyleSet().textBold.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).backgroundColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.img.isEmpty)
        ? IconButton(
            icon: SvgPicture.asset(ImagesPaths.plus),
            iconSize: 72,
            onPressed: _showAddPhoto,
          )
        : Dismissible(
            key: ValueKey(widget.img),
            direction: DismissDirection.up,
            onDismissed: (direction) {
              widget.bloc.add(AddPlaceDismissedImageEvent(widget.img));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  GestureDetector(
                    // ignore: avoid_print
                    onTap: () => print(widget.img),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: Image.file(File(widget.img)).image,
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).backgroundColor,
                      ),
                      onPressed: () => widget.bloc
                          .add(AddPlaceDismissedImageEvent(widget.img)),
                      padding: const EdgeInsets.all(0),
                    ),
                    right: -6,
                    top: -6,
                  ),
                ],
              ),
            ),
          );
  }
}
