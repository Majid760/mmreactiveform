import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGWidget extends StatelessWidget {
  final Map<String, dynamic>? data;
  const SVGWidget({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Container(
          height: 150,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigo.shade100,
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: SvgPicture.asset(data!['imagePath'],
                      semanticsLabel: 'Acme Logo'),
                ),
              ),
              Text(
                data!['id'].toString(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ]),
          )),
    );
  }
}
