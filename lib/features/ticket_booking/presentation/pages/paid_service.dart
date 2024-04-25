// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../../config/constants.dart';
import '/config/common/extensions.dart';

class PaidServicePage extends StatefulWidget {
  const PaidServicePage({Key? key}) : super(key: key);

  @override
  _PaidServicePageState createState() => _PaidServicePageState();
}

class _PaidServicePageState extends State<PaidServicePage> {
  String _selectedTemple = '';
  String _selectedTicket = '';
  String _selectedTimeSlot = '';
  int _ticketCount = 1;
  String _phoneNumber = '';
  bool _termsChecked = false;
  String _userName = '';
  String _selectedgender = '';
  String _emailId = '';
  String _address = '';
  List<String> _timeSlots = [];
  DateTime _selectedDate = DateTime.now();

  final List<String> _temples = ['Temple A', 'Temple B', 'Temple C'];
  final List<String> _genders = ['Male', 'Female', 'Trigender'];
  final Map<String, List<String>> _tickets = {
    'Temple A': ['Ticket A', 'Ticket B', 'Ticket C'],
    'Temple B': ['Ticket D', 'Ticket E', 'Ticket F'],
    'Temple C': ['Ticket G', 'Ticket H', 'Ticket I'],
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  int _currentStep = 0;

  @override
  void initState() {
    _selectedgender = _genders.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appHeader(
          context: context,
          body: LocaleText("paid",
              textAlign: TextAlign.center, style: appbarTextStyleLarge(theme)),
          trailing: IconButton(
              onPressed: () => buildNavigationDrawer(context),
              icon: const Icon(Icons.menu))),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text(""),
            label: const Text("Service"),
            isActive: true,
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //Temple Selection
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.temple_hindu_outlined),
                          3.pw,
                          Expanded(
                            child: DropdownButtonFormField(
                              value: _selectedTemple.isNotEmpty
                                  ? _selectedTemple
                                  : null,
                              hint: const Text('Select Temple'),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: _temples.map((temple) {
                                return DropdownMenuItem(
                                  value: temple,
                                  child: Text(temple),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTemple = value.toString();
                                  _selectedTicket = '';
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a temple';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.ph,
                  //Ticket Selection
                  if (_selectedTemple.isNotEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.receipt_long_outlined),
                            3.pw,
                            Expanded(
                              child: DropdownButtonFormField(
                                value: _selectedTicket.isNotEmpty
                                    ? _selectedTicket
                                    : null,
                                hint: const Text('Select Ticket'),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                items: _tickets[_selectedTemple]!.map((ticket) {
                                  return DropdownMenuItem(
                                    value: ticket,
                                    child: Text(ticket),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTicket = value.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a ticket';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  10.ph,
                  //Date Selections
                  if (_selectedTicket.isNotEmpty && _selectedTemple.isNotEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                3.pw,
                                Text(
                                  'Date of Event:',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                            2.ph,
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DatePicker(
                                    DateTime.now(),
                                    height: 90,
                                    selectionColor:
                                        Theme.of(context).colorScheme.primary,
                                    selectedTextColor: Colors.white,
                                    onDateChange: (date) {
                                      // New date selected
                                      setState(() {
                                        _selectedDate = date;
                                        _timeSlots = _getTimeSlotsForDate(date);
                                        _selectedTimeSlot =
                                            _timeSlots.isNotEmpty
                                                ? _timeSlots.first
                                                : '';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  10.ph,
                  if (_timeSlots.isNotEmpty) ...[
                    // Slot Selection
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.av_timer),
                              3.pw,
                              const Text('Time Slot:'),
                            ],
                          ),
                          2.ph,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _timeSlots.map((timeSlot) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ChoiceChip(
                                      padding: const EdgeInsets.all(8),
                                      checkmarkColor: Colors.white,
                                      label: Text(
                                        timeSlot,
                                        style: TextStyle(
                                            color: _selectedTimeSlot == timeSlot
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      selectedColor:
                                          Theme.of(context).colorScheme.primary,
                                      selected: _selectedTimeSlot == timeSlot,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _selectedTimeSlot = timeSlot;
                                        });
                                      }),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )),
                    10.ph,
                    // Count of tickets
                    const Text(
                      'Number of Tickets:',
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: const Icon(Icons.remove_circle),
                            onPressed: _ticketCount > 1
                                ? () {
                                    setState(() {
                                      _ticketCount--;
                                    });
                                  }
                                : null,
                          ),
                        ),
                        10.pw,
                        Text(
                          '$_ticketCount',
                          style: const TextStyle(fontSize: 30),
                        ),
                        10.pw,
                        Card(
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: const Icon(Icons.add_circle),
                            onPressed: _ticketCount < 10
                                ? () {
                                    setState(() {
                                      _ticketCount++;
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ],
              ),
            ),
          ),
          Step(
            title: const Text(''),
            label: const Text("Devotiee"),
            isActive: _currentStep >= 1 || _currentStep == 1,
            content: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _userName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Gender selection using radio buttons
                  const Text('Gender'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _genders.map((gender) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ChoiceChip(
                              padding: const EdgeInsets.all(8),
                              checkmarkColor: Colors.white,
                              label: Text(
                                gender,
                                style: TextStyle(
                                    color: _selectedgender == gender
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              selected: _selectedgender == gender,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedgender = gender;
                                });
                              }),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email ID'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email ID';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _emailId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address'),
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text(''),
            label: const Text("Confirmation"),
            isActive: _currentStep == 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Your form fields for step 2
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                ExpansionTile(
                  controller: _expansionTileController,
                  leading: Icon(Icons.note,
                      color: Theme.of(context).colorScheme.primary),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  // collapsedBackgroundColor:
                  //     Theme.of(context).colorScheme.primary,
                  title: const Text('Terms and Conditions'),
                  children: <Widget>[
                    //Terms and Conditions
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            '1. At the time of entry, all devotees shall produce the same original ID Proof used during booking. Age proof shall be produced for children below stipulated age to enter the Temple without booking tickets.',
                          ),
                          Text(
                            '2. The devotees shall wear Traditional Dress only. Male: Dhoti, Shirt / Kurtha, Pyjama / Pant. Female: Saree / Half Saree / Chudidar with Dupatta.',
                          ),
                          Text(
                            '3. All the devotees in group ticket have to report together.',
                          ),
                          Text(
                            '4. The devotees should not carry any luggage/electronic gadgets while reporting.',
                          ),
                          Text(
                            '5. All bookings are FINAL: Postponement / advancement/ cancellation/ refund is not allowed (if paid).',
                          ),
                          Text(
                            '6. Entry with foot wear is not permitted into the queue lines and Temple.',
                          ),
                          Text(
                            '7. Temple reserves the right of cancellation of Darshan under Special Circumstances.',
                          ),
                          Text(
                            '8. For any queries, please visit contact us page of temple website.',
                          ),
                          Text(
                            '9. Late Darshan not allowed.',
                          ),
                          Text(
                            '10. The entrance will have sanitizing stations and thermal screening, and only asymptomatic people will be allowed in.',
                          ),
                          Text(
                            '11. Footwear will have to be taken off inside your vehicle, or, if needed, kept in separate slots assigned to each individual or family.',
                          ),
                          Text(
                            '12. Entry will only be permitted to those who wear masks.',
                          ),
                          Text(
                            '13. Touching of idols, holy books and statues will not be allowed, and physical distances will have to be maintained in queues through markings.',
                          ),
                          Text(
                            '14. Physical offerings like holy water will not be permitted.',
                          ),
                          Text(
                            '15. Devotees will not be allowed to ring bells when they enter the temples and there will be no community feasts either.',
                          ),
                          Text(
                            '16. Persons above 65 years of age, persons with comorbidities, pregnant women, and children below the age of 10 years are not allowed and advised to stay at home.',
                          ),
                          Text(
                            '17. For any queries, please contact: 044-28339999.',
                          ),
                        ],
                      ),
                    ),
                    // Terms and Conditions Checkbox
                    CheckboxListTile(
                      value: _termsChecked,
                      onChanged: (value) {
                        setState(() {
                          _termsChecked = value!;
                          _expansionTileController.collapse();
                        });
                      },
                      title: const Text('I agree to the terms and conditions'),
                    ),
                    // Add other terms as needed
                  ],
                )
              ],
            ),
          ),
        ],
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Visibility(
              //   visible: _selectedTemple != '' ||
              //       _selectedTicket != '' ||
              //       _selectedTimeSlot != '' ||
              //       _ticketCount < 0 ||
              //       _phoneNumber != '' ||
              //       _termsChecked != false,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         _formKey.currentState!.reset();
              //       });
              //     },
              //     child: const Text('Reset'),
              //   ),
              // ),
              if (_currentStep != 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep -= 1;
                    });
                  },
                  child: const Text('Back'),
                ),

              Visibility(
                visible: _currentStep == 0 &&
                    _selectedTemple != '' &&
                    _selectedTicket != '' &&
                    _selectedTimeSlot != '',
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Continue'),
                ),
              ),
              Visibility(
                visible: _currentStep == 1 &&
                    _userName != "" &&
                    _selectedgender != "" &&
                    _emailId != "" &&
                    _address != "",
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Continue'),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: _termsChecked
                ? () {
                    // Handle pay button action
                    debugPrint('Payment successful');
                  }
                : null,
            child: const Text('Pay'),
          ),
        ),
      ),
    );
  }

  List<String> _getTimeSlotsForDate(DateTime date) {
    // Add your logic to generate time slots based on the selected date
    // For demonstration purposes, returning a fixed set of time slots
    return [
      '10:00 AM - 11:00 AM',
      '11:00 AM - 12:00 PM',
      '12:00 PM - 01:00 PM',
      '01:00 PM - 02:00 PM',
      '02:00 PM - 03:00 PM',
    ];
  }
}
