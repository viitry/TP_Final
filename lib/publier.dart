/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}*/

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PublierPage extends StatefulWidget {
  const PublierPage({Key? key}) : super(key: key);

  @override
  State<PublierPage> createState() => _PublierPageState();
}

class _PublierPageState extends State<PublierPage> {
  late double screenHeight, screenWidth, ctrwidth;
  String pathAsset = 'assets/images/repas.jpeg';
  var _image;
  final TextEditingController _prtitreEditingController =
      TextEditingController();
  final TextEditingController _prdescEditingController =
      TextEditingController();
  final TextEditingController _prprixEditingController =
      TextEditingController();
  final TextEditingController _prallergieEditingController =
      TextEditingController();
  final TextEditingController _prjourEditingController =
      TextEditingController();
  final TextEditingController _prlieuEditingController =
      TextEditingController();
  final TextEditingController _prinfoEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Beverage';
  var types = [
    'Baby',
    'Beverage',
    'Bread',
    'Breakfast',
    'Canned Food',
    'Condiment',
    'Care Product',
    'Dairy',
    'Dried Food',
    'Grains',
    'Frozen',
    'Snack',
    'Health',
    'Meat',
    'Miscellaneous',
    'Seafood',
    'Pet',
    'Produce',
    'Household',
    'Vegetables',
  ];

  @override
  void dispose() {
    print("dispose was called");
    _prtitreEditingController.dispose();
    _prdescEditingController.dispose();
    _prprixEditingController.dispose();
    _prallergieEditingController.dispose();
    _prjourEditingController.dispose();
    _prlieuEditingController.dispose();
    _prinfoEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: SizedBox(
        width: ctrwidth,
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 10),
            Card(
              child: GestureDetector(
                  onTap: () => {_takePictureDialog()},
                  child: SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth,
                      child: _image == null
                          ? Image.asset(pathAsset)
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _prtitreEditingController,
              decoration: InputDecoration(
                  labelText: 'Titre',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrez un titre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prdescEditingController,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.description)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: DropdownButton(
                        value: dropdownvalue,
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: types.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: _prprixEditingController,
                      decoration: InputDecoration(
                          labelText: 'Prix',
                          prefixIcon: const Icon(Icons.price_change),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un prix ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            TextFormField(
              controller: _prallergieEditingController,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'Aller',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.description)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une allergie';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _prjourEditingController,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Jour',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.description)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un jour';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _prlieuEditingController,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Lieu',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.description)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un lieu';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _prinfoEditingController,
              minLines: 2,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Info',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.description)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer des infos';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: 50,
              child: ElevatedButton(
                child: const Text("Insert"),
                onPressed: () {
                  _insertDialog();
                },
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ))),
    );
  }

  _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      //_cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      //_cropImage();
    }
  }

  /*Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }*/

  void _insertDialog() {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Add this product",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertProduct();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _insertProduct() {
    String _prtitre = _prtitreEditingController.text;
    String _prdesc = _prdescEditingController.text;
    String _prprix = _prprixEditingController.text;
    String _prallergie = _prallergieEditingController.text;
    String _prjour = _prjourEditingController.text;
    String _prlieu = _prlieuEditingController.text;
    String _prinfo = _prinfoEditingController.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());
    http.post(
        Uri.parse(
            "http://192.168.1.94/flutter_application_1/php/new_products.php"),
        body: {
          "titre": _prtitre,
          "desc": _prdesc,
          "prix": _prprix,
          "allergie": _prallergie,
          "jour": _prjour,
          "lieu": _prlieu,
          "info": _prinfo,
          "type": dropdownvalue,
          "image": base64Image,
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
