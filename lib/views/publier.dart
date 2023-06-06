import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PublierPage extends StatefulWidget {
  const PublierPage({Key? key}) : super(key: key);

  @override
  State<PublierPage> createState() => _PublierPageState();
}

class _PublierPageState extends State<PublierPage> {
  late String username;

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
      });
    }
  }

  List<DateTime> _selectedDates = [];

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_selectedDates.isNotEmpty) {
      initialDate = _selectedDates.last;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && !_selectedDates.contains(picked)) {
      setState(() {
        _selectedDates.add(picked);
        _prjourEditingController.text = _selectedDates
            .map((date) => DateFormat('dd/MM/yyyy').format(date))
            .join(', ');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

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
  String dropdownvalue = 'Burger';
  var types = [
    'Pizza',
    'Burger',
    'Dessert',
    'Vegetarien',
    'Entree',
    'Petit-dejeuner',
    'Boisson',
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
                      height: screenHeight / 3,
                      width: screenWidth,
                      child: _image == null
                          ? Image.asset(pathAsset)
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ))),
            ),
            const SizedBox(height: 10),
            Container(
              child: TextFormField(
                controller: _prtitreEditingController,
                decoration: InputDecoration(
                    labelText: 'Choisissez un titre',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez un titre valide';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prdescEditingController,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                  labelText: 'Decrivez votre plat, les ingredients ...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
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
                              const BorderRadius.all(Radius.circular(25.0))),
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
                          labelText: 'Choisissez un prix',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un prix ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prallergieEditingController,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'Oeuf, lait, arachide ...(optionnel) ',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prjourEditingController,
              onTap: () {
                _selectDate(context);
              },
              readOnly: true,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Choisissez une plusieurs dates',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              validator: (value) {
                if (_selectedDates.isEmpty) {
                  return 'Veuillez sélectionner au moins une date';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prlieuEditingController,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText:
                      'Entrez votre ville (arrondissemement ou quartier si possible)',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un lieu';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _prinfoEditingController,
              minLines: 2,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Quantite / nombre de personnes ',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir les quantites et/ou le nombres de personnes';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            SizedBox(
                width: screenWidth,
                height: 50,
                child: ElevatedButton(
                  child: const Text("Publier"),
                  onPressed: () {
                    _insertDialog();
                  },
                )),
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
        return AlertDialog(
            title: const Text(
              "Veuillez choisir",
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
                    label: const Text("Galerie")),
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
    }
  }

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
              "Ajouter ce produit",
              style: TextStyle(),
            ),
            content: const Text("Etes vous sur ?", style: TextStyle()),
            actions: <Widget>[
              GestureDetector(
                child: TextButton(
                  child: const Text(
                    "Oui",
                    style: TextStyle(),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _insertProduct();
                  },
                ),
              ),
              TextButton(
                child: const Text(
                  "Non",
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
          "categorie": dropdownvalue,
          "image": base64Image,
          "username": username,
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
