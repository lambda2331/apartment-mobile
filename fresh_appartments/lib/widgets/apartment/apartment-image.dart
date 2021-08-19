import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AppartmentImage extends StatelessWidget {
  final List<String> images;

  const AppartmentImage({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.length == 0) {
      return Container(
        child: Image.asset(
          'images/no-photo.jpg',
          height: 200,
        ),
      );
    }

    return Container(
        child: CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 1,
        aspectRatio: 1.5,
        initialPage: 0,
        enableInfiniteScroll: images.length > 0 ? true : false,
      ),
      itemBuilder: (context, index, realIndex) {
        return Image.network(
          images[index],
          fit: BoxFit.fill,
          width: double.infinity,
          errorBuilder: (context, exception, trace) {
            return Image.asset('images/no-photo.jpg');
          },
        );
      },
    ));
  }
}
