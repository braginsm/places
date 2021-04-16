import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String url = "";

  final BoxFit fit = BoxFit.fill;

  const ImageNetwork(url, {Key key, fit = BoxFit.fill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }
}