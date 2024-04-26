import 'dart:io';
import 'package:community_service/models/event_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class CompleteInfo extends StatefulWidget {
  const CompleteInfo({super.key});

  @override
  State<CompleteInfo> createState() => _CompleteInfoState();
}

class _CompleteInfoState extends State<CompleteInfo> {
  bool pressSubmit = false;
  bool showloading = false;
  Uint8List? _image;
  Uint8List? _image2;
  File? selectedIMage1;
  File? selectedIMage2;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController maxController = TextEditingController();
  final TextEditingController organizerNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0);
  String fromTime = "From*";
  String toTime = "To*";
  String selectedDates = "Date*";

  List<TextEditingController> listController = [];

  void _showTimePickerFrom() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value == null) {
          fromTime = "From*";
        } else {
          double timeCheck =
              value.hour.toDouble() + value.minute.toDouble() / 60;
          if (timeCheck >= 5) {
            timeOfDay = value;
            fromTime = value.format(context).toString();
          } else {
            var sb = const SnackBar(
              content: Text(
                "Invalid Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(sb);
          }
        }
      });
    });
  }

  void _showTimePickerTo() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value == null) {
          toTime = "To*";
        } else {
          double timeCheck =
              value.hour.toDouble() + value.minute.toDouble() / 60;
          double fromCheck =
              timeOfDay.hour.toDouble() + timeOfDay.minute.toDouble() / 60;
          double toCheck = value.hour.toDouble() + value.minute.toDouble() / 60;
          if (fromCheck < toCheck && timeCheck <= 24) {
            toTime = value.format(context).toString();
          } else {
            var sb = const SnackBar(
              content: Text(
                "Invalid Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(sb);
          }
        }
      });
    });
  }

  String emptSpace = "  ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create an Event",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        forceMaterialTransparency: true,
      ),
      backgroundColor: const Color(0xFFECEFF3),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "  Event Information  ",
                    style: TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Stack(
                children: [
                  _image != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 165,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F8FF),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: Image.memory(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 165,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F8FF),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Event Image",
                              style: TextStyle(
                                color: Color(0xff8A8B8B),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 6,
                    right: 24,
                    child: IconButton(
                      onPressed: () {
                        _pickImageFromGallery1();
                      },
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Color(0xFFECEFF3)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF144E73),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: eventNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Event Name*",
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: eventLocationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Event Location*",
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 3),
                        );
                        if (dateTimeRange != null) {
                          setState(() {
                            String start =
                                "${dateTimeRange.start.day}/${dateTimeRange.start.month}/${dateTimeRange.start.year}";
                            String end =
                                "${dateTimeRange.end.day}/${dateTimeRange.end.month}/${dateTimeRange.end.year}";
                            if (start == end) {
                              selectedDates = start;
                            } else {
                              selectedDates = "$start - $end";
                            }
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Color(0xff8A8B8B),
                      ),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: selectedDates,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * 0.48,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: Color(0xff8A8B8B),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8FF),
                          hintText: fromTime,
                          suffixIcon: IconButton(
                            onPressed: _showTimePickerFrom,
                            icon: const Icon(
                              Icons.alarm,
                              color: Color(0xff8A8B8B),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width * 0.48,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: Color(0xff8A8B8B),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8FF),
                          hintText: toTime,
                          suffixIcon: IconButton(
                            onPressed: _showTimePickerTo,
                            icon: const Icon(
                              Icons.alarm,
                              color: Color(0xff8A8B8B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: maxController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Maximum No. of Participants*",
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: eventDescriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Event Description",
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "  Organizer Information  ",
                    style: TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      _image2 != null
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: MemoryImage(_image2!),
                            )
                          : const CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            _pickImageFromGallery2();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xFFECEFF3),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF144E73),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: organizerNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Organizer Name*",
                  ),
                ),
              ),
              // SizedBox(
              //   height: 12,
              // ),
              ListView.builder(
                clipBehavior: Clip.none,
                physics:
                    const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: listController.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 25,
                              spreadRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: listController[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: Color(0xff8A8B8B),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8FF),
                            hintText: "Presenter Name",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  listController[index].clear();
                                  listController[index].dispose();
                                  listController.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Color(0xff8A8B8B),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    listController.add(TextEditingController());
                  });
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0x408A8B8B),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: 150,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                        color: Color(0xff8A8B8B),
                      ),
                      Text(
                        "Add Presenter",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff8A8B8B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff8A8B8B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8FF),
                    hintText: "Notes",
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 24),
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              print("Created Event");
              _uploadEventOrg();
              setState(() {
                showloading = !showloading;
                pressSubmit = !pressSubmit;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF144E73),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          child: showloading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Wait Submitting",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

//Gallery
  Future _pickImageFromGallery1() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage1 = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future _pickImageFromGallery2() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage2 = File(returnImage.path);
      _image2 = File(returnImage.path).readAsBytesSync();
    });
  }

  Future<void> _uploadEventOrg() async {
    if (selectedIMage1 == null) {
      return;
    }
    final DatabaseReference organizerRef =
        FirebaseDatabase.instance.ref().child('events');

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('events/$fileName.jpg');
    Reference storageReferenceOrg =
        FirebaseStorage.instance.ref().child('organizer/$fileName.jpg');
    UploadTask uploadTask = storageReference.putFile(selectedIMage1!);
    TaskSnapshot snapshot = await uploadTask;
    UploadTask uploadTask2 = storageReferenceOrg.putFile(selectedIMage2!);
    TaskSnapshot snapshot2 = await uploadTask2;
    if (snapshot.state == TaskState.success) {
      String downloadUrl = await storageReference.getDownloadURL();
      String pName = "NotAssigned";
      if (listController.length > 0) {
        pName = listController[0].text;
      }
      if (snapshot2.state == TaskState.success) {
        String downloadUrlOrg = await storageReferenceOrg.getDownloadURL();
        var eventObj = EventDetails(
            evenImageUrl: '$downloadUrl',
            organizerPic: '$downloadUrlOrg',
            organizerName: '${organizerNameController.text}',
            presenterName: '$pName',
            organizernote: '${notesController.text}',
            eventName: '${eventNameController.text}',
            eventLocation: '${eventLocationController.text}',
            eventDate: '$selectedDates',
            eventTiming: '$fromTime to $toTime',
            numOfParticipants: '${maxController.text}',
            eventDesc: '${eventDescriptionController.text}');

        organizerRef.push().set(eventObj.toMap()).then((_) {
          print('Event added successfully!');
          Navigator.pushNamed(context, '/homeScreen');
          // Navigator.pushNamed(context, '/createEventScreen', arguments: "${organizerRef.key}");
        }).catchError((error) {
          print('Failed to add event: $error');
        });

        // Now you can save the downloadUrl, description, and price to Firebase Database or Firestore
        // For simplicity, let's just print the details here
        print("*************************************");
        print('Download URL: $downloadUrl');
        print('Download URL: $downloadUrlOrg');
        print("*************************************");
      }
    }
  }
}
