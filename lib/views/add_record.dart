import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/common/constants.dart';
import 'package:getx_tutorial/models/record.dart';
import 'package:getx_tutorial/viewmodels/controller.dart';
import 'package:getx_tutorial/widgets/weight_picker_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final Controller _controller = Get.find();
  TextEditingController _noteController = TextEditingController();
  int _weight = 70;
  DateTime _selectedDate = DateTime.now();
  File? _imageFile;
  //Local path of photo, if user takes one, to be saved in a record
  String? _photoUrl;

  //Callback function for WeighPickerCard
  void setWeight(int value) {
    _weight = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Record'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeightPickerCard(onChanged: setWeight, initialValue: _weight),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Constants.cornerRadii)),
                child: GestureDetector(
                  onTap: () async {
                    _selectedDate = await pickDate(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Icon(FontAwesomeIcons.calendar, size: 40),
                        ),
                        Expanded(
                            child: Text(
                          DateFormat('EEE, MMM d').format(_selectedDate),
                          /* style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20) */
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                //margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Constants.cornerRadii)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Icon(FontAwesomeIcons.stickyNote, size: 40),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: _noteController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Optional Note',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              /* disabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange)), */
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              /* border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ), */
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        await captureSaveImageToExternalStorage();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 40,
                      )),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightForFinite(
                      width: double.infinity,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Constants.cornerRadii - 4)),
                      ),
                      onPressed: () {
                        handleSave();
                      },
                      child: Text('Save Record'),
                    ),
                  ),
                ],
              ),
              Container(
                child: (_photoUrl == null)
                    ? Container()
                    : Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12),
                          //child: Text('AAA'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(_photoUrl!))
                                //image: FileImage(_imageFile!))),
                                ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate.subtract(Duration(days: 365)),
        lastDate: initialDate.add(
          Duration(days: 30),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              accentColor: Colors.black,
              colorScheme: ColorScheme.light(
                  primary: Colors.black,
                  primaryVariant: Colors.black,
                  secondaryVariant: Colors.black,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        });
    if (newDate != null) {
      return newDate;
    } else {
      return _selectedDate;
    }
  }

  void handleSave() {
    Record newRecord = Record(
        dateTime: _selectedDate,
        weight: _weight,
        note: _noteController.text,
        photoUrl: _photoUrl);
    _controller.addRecord(newRecord);
    Get.back();
  }

  Future<File?> captureSaveImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 200);

    if (pickedImage == null) return null;

    _imageFile = File(pickedImage.path);
    // check if exists
    print('image from camera exists ? : ${_imageFile!.existsSync()}');

    // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    print('application directory to save images: ${extDir.path}');

    // set image name from DateTime
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$dirPath/$imageName.jpg';
    print(filePath);

    // copy the file to a new path
    final File newImage = await _imageFile!.copy(filePath);
    setState(() {
      print('setstate called');
      _imageFile = newImage;
    });
    print('image copy on $filePath ? : ${newImage.existsSync()}');

    // save photoUrl to state variable
    _photoUrl = filePath;
    print('File(photoUrl!).existsSync() : ${File(_photoUrl!).existsSync()}');
  }

  /// This alternative method can be used to save images to external path
  /// however requires some permissions
  Future<File?> captureSaveImageToExternalStorage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 200);
    //print(pickedImage!.name);
    //print(pickedImage.path);

    if (pickedImage == null) return null;

    //_imageFile = File(pickedImage.path);
    // check if exists
    //print('image from camera exists ? : ${_imageFile!.existsSync()}');

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //String imageName = 'test';
    File newImageFile;
    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null)
        _imageFile = await File(pickedImage.path)
            .copy('${directory.path}/$imageName.jpg');
    } catch (e) {
      return null;
    }

    setState(() {});
    //print('image copy on $filePath ? : ${newImage.existsSync()}');

    // save photoUrl to state variable
    _photoUrl = _imageFile!.path;
    print('File(photoUrl!).existsSync() : ${File(_photoUrl!).existsSync()}');
    print(_photoUrl);
  }
}
