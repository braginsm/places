import 'package:flutter/material.dart';

class ImageNetworkWithProgress extends StatelessWidget {
  final String url;

  final BoxFit fit;

  const ImageNetworkWithProgress(this.url, {Key? key, this.fit = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).accentColor,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

class ImageNetworkWithPlaceholder extends StatefulWidget {
  final String url;

  final BoxFit? fit;
  const ImageNetworkWithPlaceholder(this.url, {Key? key, this.fit})
      : super(key: key);

  @override
  _ImageNetworkWithPlaceholderState createState() =>
      _ImageNetworkWithPlaceholderState();
}

class _ImageNetworkWithPlaceholderState
    extends State<ImageNetworkWithPlaceholder> {

  Image? _image;
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    _image = Image.network(widget.url, fit: widget.fit,);
    _image!.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((_, __) {
          if (mounted) {
            setState(() {
              _crossFadeState = CrossFadeState.showSecond;
            });
          }
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Center(child: Image.asset("res/images/placeholder.png", fit: widget.fit,)), 
      secondChild: SizedBox(child: _image, width: double.infinity,), 
      crossFadeState: _crossFadeState, 
      duration: const Duration(seconds: 1),
    );
  }
}
