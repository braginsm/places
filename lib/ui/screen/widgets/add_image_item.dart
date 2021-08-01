import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';

class AddImageItem extends StatefulWidget {
  final String img;
  final AddPlaceBloc bloc;
  AddImageItem({Key key, this.img, this.bloc}) : super(key: key);

  @override
  _AddImageItemState createState() => _AddImageItemState();
}

class _AddImageItemState extends State<AddImageItem> {

  void _showAddPhoto() {
    showDialog(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(
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
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: SvgPicture.asset(ImagesPaths.camera),
                          ),
                          Text("Камера"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: SvgPicture.asset(ImagesPaths.photo),
                          ),
                          Text("Фотография"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: SvgPicture.asset(ImagesPaths.file),
                          ),
                          Text("Файл"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "ОТМЕНА",
                      style: TextStyleSet().textBold.copyWith(
                            color: Theme.of(context).accentColor,
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
    return (widget.img == null || widget.img.isEmpty)
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
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => print(widget.img),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: Image.network(widget.img).image,
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
                    onPressed: () =>
                        widget.bloc.add(AddPlaceDismissedImageEvent(widget.img)),
                    padding: EdgeInsets.all(0),
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
