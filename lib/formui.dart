import 'package:flutter/material.dart';
import 'package:mmreactiveform/controllers/image_controller.dart';
import 'package:mmreactiveform/database/database_service.dart';
import 'package:mmreactiveform/image_picker.dart';
import 'package:mmreactiveform/user_profile_list.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormUi extends StatefulWidget {
  const FormUi({Key? key, this.formGroup, this.formData}) : super(key: key);
  final FormGroup? formGroup;
  final Map<String, Object?>? formData;

  @override
  _FormUiState createState() => _FormUiState();
}

class _FormUiState extends State<FormUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bio Data!'),
        centerTitle: true,
        leading: Consumer<ImagePickerController>(
          builder: (context, imageController, _) => IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
              imageController.setXFileImageToNull();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ReactiveForm(
            formGroup: widget.formGroup!,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: ImagePickingWidget(
                      imageName: (widget.formData!.isEmpty)
                          ? "null"
                          : widget.formData!['image'].toString(),
                    )),
                ReactiveTextField<String>(
                  formControlName: 'first_name',
                  decoration: const InputDecoration(
                    labelText: 'first name',
                  ),
                  validationMessages: (errors) => {
                    ValidationMessage.required: 'first name must  not be empty',
                    ValidationMessage.minLength:
                        'first name must  be greater 2 characters',
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'last_name',
                  decoration: const InputDecoration(
                    labelText: 'last name',
                  ),
                  validationMessages: (errors) => {
                    ValidationMessage.required: 'last name must not be empty',
                    ValidationMessage.minLength:
                        'last name must  be greater 2 characters',
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'cnic',
                  decoration: const InputDecoration(
                    labelText: 'cnic',
                  ),
                  validationMessages: (errors) => {
                    ValidationMessage.required: 'cnic must not be empty',
                    ValidationMessage.minLength:
                        'enter valid cnic number without i.e 3450556765898',
                    ValidationMessage.maxLength:
                        'enter valid cnic number without i.e 3450556765898'
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        width: 70,
                        child: ReactiveRadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          formControlName: 'gender',
                          title: const Text('Male'),
                          value: 'male',
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        width: 70,
                        child: ReactiveRadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          formControlName: 'gender',
                          title: const Text('Female'),
                          value: 'female',
                          toggleable: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        width: 70,
                        child: ReactiveRadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          formControlName: 'gender',
                          title: const Text('Other'),
                          value: 'other',
                          toggleable: true,
                        ),
                      ),
                    )
                  ],
                ),
                ReactiveDropdownField<String>(
                  formControlName: 'country',
                  decoration: const InputDecoration(
                    labelText: 'select country',
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'pakistan', child: Text('Pakistan')),
                    DropdownMenuItem(value: 'india', child: Text('India')),
                    DropdownMenuItem(
                        value: 'banglades', child: Text('Bangladesh')),
                    DropdownMenuItem(
                        value: 'srilanka', child: Text('Sri Lanka')),
                  ],
                ),
                ReactiveTextField<String>(
                  maxLines: 5,
                  minLines: 5,
                  formControlName: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validationMessages: (errors) => {
                    ValidationMessage.required: 'description must not be empty',
                  },
                ),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return Consumer<ImagePickerController>(
                        builder: (context, imagePickerController, _) => (widget
                                .formData!.isEmpty)
                            ? ElevatedButton(
                                onPressed: form.valid
                                    ? () {
                                        if (form.valid) {
                                          int createdDate = (DateTime.now()
                                              .millisecondsSinceEpoch);
                                          int updatedDate = (DateTime.now()
                                              .millisecondsSinceEpoch);
                                          form.value;
                                          Map<String, dynamic> formData = {};
                                          formData.addAll(form.value);
                                          formData['image'] =
                                              (imagePickerController
                                                          .xFileImage ==
                                                      null)
                                                  ? ''
                                                  : imagePickerController
                                                      .xFileImage!.name;
                                          formData['created_date'] =
                                              createdDate;
                                          formData['updated_date'] =
                                              updatedDate;
                                          DatabaseService.instance
                                              .insertProfile(
                                                  'profile', formData);
                                          imagePickerController
                                              .setXFileImageToNull();
                                          Navigator.pop(context);
                                        }
                                      }
                                    : null,
                                child: const Text('Submit'),
                              )
                            : ElevatedButton(
                                onPressed: form.valid
                                    ? () {
                                        if (form.valid) {
                                          int updatedDate = (DateTime.now()
                                              .millisecondsSinceEpoch);
                                          Map<String, dynamic> formDataUpdate =
                                              {};
                                          formDataUpdate.addAll(form.value);
                                          formDataUpdate['image'] =
                                              (imagePickerController
                                                          .xFileImage ==
                                                      null)
                                                  ? widget.formData!['image']
                                                  : imagePickerController
                                                      .xFileImage!.name;
                                          formDataUpdate['created_date'] =
                                              widget.formData!['created_date'];
                                          formDataUpdate['updated_date'] =
                                              updatedDate;
                                          DatabaseService.instance
                                              .updateProfile(
                                                  'profile', formDataUpdate);
                                          imagePickerController
                                              .setXFileImageToNull();
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const UserProfileListing(),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                child: const Text('UPDATE'),
                              ));
                  },
                ),
                ElevatedButton(
                  onPressed: () => widget.formGroup!.reset(),
                  child: const Text('RESET'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
