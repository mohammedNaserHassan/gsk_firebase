import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
class video_container extends StatelessWidget {

  video_container();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/images/vp.png'),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration:
                BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
            child: Icon(
              Icons.play_arrow,
              size: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
