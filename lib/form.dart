import 'package:flutter/material.dart';
import 'package:mmreactiveform/database/database_service.dart';
import 'package:mmreactiveform/formui.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormGenerator {
  Map<String, Object?> formData = {};
  void initData(int? userid, BuildContext context) {
    if (userid != 0) {
      getSingleUserData(userid, context);
    } else {
      FormGroup fg = getForm(0);
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              FormUi(formGroup: fg, formData: formData),
        ),
      );
    }
  }

  getSingleUserData(int? id, BuildContext context) async {
    final data =
        await DatabaseService.instance.getSingleUserProfile(id!, "profile");
    formData = data[0];
    String imagePath = formData['image'].toString();
    FormGroup fg = getForm(id);
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            FormUi(formGroup: fg, formData: formData),
      ),
    );
  }

  FormGroup getForm(int? userid) {
    if (userid == 0) {
      return fb.group(<String, Object>{
        'first_name': FormControl<String>(
            value: '',
            validators: [Validators.required, Validators.minLength(3)]),
        'last_name': FormControl<String>(
            value: '',
            validators: [Validators.required, Validators.minLength(3)]),
        'cnic': FormControl<String>(value: '', validators: [
          Validators.required,
          Validators.minLength(13),
          Validators.maxLength(13)
        ]),
        'gender': FormControl<String>(
            value: 'male', validators: [Validators.required]),
        'country': FormControl<String>(
            value: 'pakistan', validators: [Validators.required]),
        'description':
            FormControl<String>(value: '', validators: [Validators.required]),
      });
    } else {
      return fb.group(<String, Object>{
        'first_name': FormControl<String>(
            value: formData['first_name'].toString(),
            validators: [Validators.required, Validators.minLength(3)]),
        'last_name': FormControl<String>(
            value: formData['last_name'].toString(),
            validators: [Validators.required, Validators.minLength(3)]),
        'cnic': FormControl<String>(
            value: formData['cnic'].toString(),
            validators: [Validators.required, Validators.minLength(13)]),
        'gender': FormControl<String>(
            value: formData['gender'].toString(),
            validators: [Validators.required]),
        'country': FormControl<String>(
            value: formData['country'].toString(),
            validators: [Validators.required]),
        'description': FormControl<String>(
            value: formData['description'].toString(),
            validators: [Validators.required]),
      });
    }
  }
}
