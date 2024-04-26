import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

final TextEditingController eventNameController = TextEditingController();
final TextEditingController eventLocationController = TextEditingController();
final TextEditingController eventDescriptionController =
    TextEditingController();
final TextEditingController maxController = TextEditingController();
TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0);
String fromTime = "From*";
String toTime = "To*";
String selectedDates = "Date*";
File eventImage = File("");

class _EventInfoState extends State<EventInfo> {
  Uint8List? _image;
  File? selectedImage;
  final _formkey = GlobalKey<FormState>();

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
          // print("*********************");
          // print(fromCheck);
          // print(toCheck);
          // print("*********************");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Event Information",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      backgroundColor: const Color(0xFFECEFF3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
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
                          fit: BoxFit.cover,
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
                            ),
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 6,
                  right: 24,
                  child: IconButton(
                    onPressed: () {
                      _pickImageFromGallery();
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
            Form(
              key: _formkey,
              child: Column(
                children: [
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
                              firstDate: DateTime(DateTime.now().day),
                              lastDate: DateTime(DateTime.now().year + 3),
                            );
                            if (dateTimeRange != null &&
                                dateTimeRange.start.day >= DateTime.now().day &&
                                dateTimeRange.end.day >= DateTime.now().day &&
                                dateTimeRange.start.day <=
                                    dateTimeRange.end.day) {
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
                            } else {
                              var sb = const SnackBar(
                                content: Text(
                                  "Invalid Date",
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
                        hintText: selectedDates,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: 199,
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
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        width: 199,
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
                        hintText: "Event Description",
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 24),
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              Navigator.pushNamed(context, '/createEventInfoScreen');
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
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              "Continue",
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
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      eventImage = selectedImage!;
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

// //Camera
//   Future _pickImageFromCamera() async {
//     final returnImage =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnImage == null) return;
//     setState(() {
//       selectedIMage = File(returnImage.path);
//       _image = File(returnImage.path).readAsBytesSync();
//     });
//     Navigator.of(context).pop();
//   }
}
