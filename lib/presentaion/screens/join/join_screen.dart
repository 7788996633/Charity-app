import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import '../../../data/cubits/volunteer_request_cubit/volunteer_request_cubit.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  JoinScreenState createState() => JoinScreenState();
}

class JoinScreenState extends State<JoinScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studyController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final Map<String, TimeOfDay?> _startTimes = {};
  final Map<String, TimeOfDay?> _endTimes = {};

  final List<String> _daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    for (var day in _daysOfWeek) {
      _startTimes[day] = null;
      _endTimes[day] = null;
    }
  }

  bool _isAnyTimeProvided() {
    for (var day in _daysOfWeek) {
      if (_startTimes[day] != null && _endTimes[day] != null) {
        return true;
      }
    }
    return false;
  }

  Map<String, List<String>> _getAvailableTimes() {
    final Map<String, List<String>> availableTimes = {};
    for (var day in _daysOfWeek) {
      final start = _startTimes[day];
      final end = _endTimes[day];
      if (start != null && end != null) {
        availableTimes[day.toLowerCase()] = [
          start.format(context),
          end.format(context)
        ];
      }
    }
    return availableTimes;
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTimes[day] ?? TimeOfDay.now())
          : (_endTimes[day] ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTimes[day] = picked;
        } else {
          _endTimes[day] = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VolunteerRequestCubit(),
      child: CustomScaffold(
        appBarActions: const Text(""),
        appBarTitle: "Join us",
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      "Are you ready to be one of our community?",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CustomContainar(
                    child: Column(
                      children: [
                        const Text(
                          textAlign: TextAlign.start,
                          "Please fill out the following information to volunteer:",
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text(
                          "Enter your study:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextFormField(
                          controller: _studyController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Study (e.g., Computer Science)",
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your study field.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                          "Enter your available time for each day:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        ..._daysOfWeek.map((day) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                day,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _selectTime(context, day, true),
                                      child: Text(
                                        _startTimes[day] != null
                                            ? "Start: ${_startTimes[day]!.format(context)}"
                                            : "Select Start Time",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _selectTime(context, day, false),
                                      child: Text(
                                        _endTimes[day] != null
                                            ? "End: ${_endTimes[day]!.format(context)}"
                                            : "Select End Time",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            ],
                          );
                        }),
                        const Text(
                          "Enter your skills:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextFormField(
                          controller: _skillsController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Skills (e.g., Programming, Design)",
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your skills.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        BlocConsumer<VolunteerRequestCubit,
                            VolunteerRequestState>(
                          listener: (context, state) {
                            if (state is VolunteerRequestSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.successmsg)),
                              );
                            } else if (state is VolunteerRequestFail) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errmsg)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is VolunteerRequestLoading) {
                              return const CircularProgressIndicator();
                            }

                            return CustomMaterialButton(
                              text: "Confirm",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (!_isAnyTimeProvided()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please enter at least one available time.'),
                                      ),
                                    );
                                    return;
                                  }

                                  final study = _studyController.text;
                                  final skills = _skillsController.text;
                                  final availableTimes = _getAvailableTimes();

                                  context.read<VolunteerRequestCubit>().volReq(
                                        study,
                                        skills,
                                        availableTimes.toString(),
                                      );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
