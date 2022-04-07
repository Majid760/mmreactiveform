import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mmreactiveform/controllers/image_controller.dart';
import 'package:mmreactiveform/database/database_service.dart';
import 'package:mmreactiveform/form.dart';
import 'package:provider/provider.dart';

class UserProfileListing extends StatefulWidget {
  const UserProfileListing({Key? key}) : super(key: key);

  @override
  _UserProfileListingState createState() => _UserProfileListingState();
}

class _UserProfileListingState extends State<UserProfileListing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Profiles'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: MediaQuery.of(context).size.height * .80,
            child: FutureBuilder(
              future: DatabaseService.instance.getAllProfiles(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(children: const [
                    Center(child: CircularProgressIndicator()),
                    Spacer(),
                  ]);
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text(
                        'Something went Wrong to fetching the products!');
                  } else if (snapshot.hasData) {
                    List profiles = snapshot.data!;
                    return (profiles.isNotEmpty)
                        ? Center(
                            child: ListView.builder(
                              itemCount: profiles.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  elevation: 3,
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Consumer<ImagePickerController>(
                                            builder: (context, controller, _) =>
                                                (profiles[index]['image']
                                                            .toString()
                                                            .isNotEmpty &&
                                                        profiles[index]
                                                                ['image'] !=
                                                            null)
                                                    ? Image.file(
                                                        File(
                                                            '${controller.getDirectoryPath!}/${profiles[index]['image']}'),
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.fill)
                                                    : ((profiles[index]
                                                                    ['gender']
                                                                .toString() ==
                                                            'male')
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child: Image.asset(
                                                                'assets/images/male.jpg'),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child: Image.asset(
                                                                'assets/images/women.jpg'),
                                                          ))),
                                      ),
                                    ),
                                    title:
                                        Text('${profiles[index]['first_name']} '
                                            '${profiles[index]['last_name']}'),
                                    subtitle:
                                        Text('${profiles[index]['cnic']}'),
                                    trailing: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      splashColor: Colors.blue.shade50,
                                      radius: 30,
                                      child: SizedBox(
                                        height: 80,
                                        width: 60,
                                        child: Center(
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue.shade300),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Map<String, Object> formData = {};
                                        formData['first_name'] =
                                            profiles[index]['first_name'];
                                        formData['last_name'] =
                                            profiles[index]['last_name'];
                                        formData['cnic'] =
                                            profiles[index]['cnic'];
                                        formData['gender'] =
                                            profiles[index]['gender'];
                                        formData['country'] =
                                            profiles[index]['country'];
                                        formData['image'] =
                                            profiles[index]['image'];
                                        formData['description'] =
                                            profiles[index]['description'];
                                        formData['created_date'] =
                                            profiles[index]['created_date'];
                                        formData['updated_date'] =
                                            profiles[index]['updated_date'];
                                        // Navigator.push<void>(
                                        //   context,
                                        //   MaterialPageRoute<void>(
                                        //     builder: (BuildContext context) =>
                                        //         ProfileFormWidget(
                                        //             userId: int.parse(
                                        //                 profiles[index]
                                        //                         ['created_date']
                                        //                     .toString())),
                                        //   ),
                                        // );
                                        FormGenerator().initData(
                                            profiles[index]['created_date'],
                                            context);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text('no data found!'),
                          );
                  } else {
                    return const Center(child: Text('No Data found!'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push<void>(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) =>
                  //         ,
                  //   ),
                  // );
                  FormGenerator().initData(0, context);
                },
                child: const Text('Add User')),
          )
        ],
      ),
    );
  }
}
