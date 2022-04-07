import 'package:flutter/material.dart';
import 'package:mmreactiveform/form.dart';
import 'package:mmreactiveform/svgscreen.dart';
import 'package:mmreactiveform/user_profile_list.dart';
import 'package:mmreactiveform/widgets/square_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> profile = ['users', 'admin', 'team'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('User card'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5),
                itemCount: profile.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SvgScreen(),
                        ),
                      );
                    },
                    child: SquareWidget(
                      title: profile[index],
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Add User'),
                  onPressed: () {
                    FormGenerator().initData(0, context);
                  },
                ),
              )
            ]),
      ),
    );
  }
}
