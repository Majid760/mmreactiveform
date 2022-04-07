import 'package:flutter/material.dart';
import 'package:mmreactiveform/database/database_service.dart';
import 'package:mmreactiveform/utility/search_utility.dart';
import 'package:mmreactiveform/widgets/svg_widget.dart';

class SvgScreen extends StatefulWidget {
  const SvgScreen({Key? key}) : super(key: key);

  @override
  _SvgScreenState createState() => _SvgScreenState();
}

class _SvgScreenState extends State<SvgScreen> {
  List<Map> userProfiles = [];

  @override
  void initState() {
    super.initState();
    getAllUserProfileData();
  }

  void getAllUserProfileData() async {
    final data = await DatabaseService.instance.getAllProfiles();
    setState(() {
      userProfiles = data;
    });
  }

  List<Map<String, dynamic>> svgData = [
    {
      'imagePath': "assets/images/woman.svg",
      'id': 1234233,
    },
    {
      'imagePath': "assets/images/woman.svg",
      'id': 12342344,
    },
    {
      'imagePath': "assets/images/male.svg",
      'id': 1243421,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Profiles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 5),
          itemCount: svgData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ProfileSearch(userProfiles: userProfiles),
                );
              },
              child: SVGWidget(
                data: svgData[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
