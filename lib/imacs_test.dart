import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imacs/animated_toggle.dart';

class ImacsScreen extends StatefulWidget {
  const ImacsScreen({super.key});
  @override
  State<ImacsScreen> createState() => _ImacsScreenState();
}

class _ImacsScreenState extends State<ImacsScreen> {
  bool? trueFalseRadio;
  final _gatewayId = TextEditingController();
  final _bedexId = TextEditingController();
  final _wetId = TextEditingController();
  final _bedexBatlvl = TextEditingController();
  final _wetBatlvl = TextEditingController();
  final _diaperNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _bedex_bluetooth = true;
  bool _gatewayOnline = true;
  bool _hold_button = true;
  bool _wakeup = true;
  bool _rolling = true;
  bool _ncall = true;
  bool _wetsafe_bluetooth_connected = true;
  String? _gatewayIdError;
  String? _bedexIdError;
  String? _wetIdError;
  String? _bedexbatlvlError;
  String? _wetbatlvlError;
  String? _diaperError;

  Future<void> _ImacsTest() async {
    final gateId = _gatewayId.text;
    final bedId = _bedexId.text;
    final bedlvlId = int.parse(_bedexBatlvl.text);
    final wetlvsId = int.parse(_wetBatlvl.text);
    final diaper = int.parse(_diaperNumber.text);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final url = 'https://4vtwomebzc.execute-api.ap-south-1.amazonaws.com/dev/device';

    final body = jsonEncode({
      'gatewayId': gateId,
      'bedexId': bedId,
      'bedex_batlevel': bedlvlId,
      'bedex_bluetooth_connected': _bedex_bluetooth,
      'wet_batlevel': wetlvsId,
      'gatewayOnline': _gatewayOnline,
      'hold_button': _hold_button,
      'wakeup': _wakeup,
      'rolling': _rolling,
      'ncall': _ncall,
      'diaper': diaper,
      'wetsafe_bluetooth_connected': _wetsafe_bluetooth_connected
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 201) {
        print('Message sent successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Tested Successfully - Status Code: ${response.statusCode}'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating, // or SnackBarBehavior.fixed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.green, // Customize the background color.
            elevation: 6.0, // Customize the elevation.
            margin:
                EdgeInsets.all(16.0), // Add some margin around the SnackBar.
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding.
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                // You can add an action here if needed.
              },
            ),
          ),
        );
        print(response.body);
      } else {
        print('Error sending message - Status Code: ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error sending message - Status Code: ${response.statusCode}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Error sending message: ${error}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending message: $error'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  String? validateBedexId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your BedexId';
    }
    return null;
  }

  String? validateWetId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your WetId';
    }
    return null;
  }

  String? validateGatewayId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your GateWayId';
    }
    return null;
  }

  String? validateWetBatLvl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your WetBatLvl';
    }

    try {
      final intValue = int.parse(value);
      if (intValue >= 100) {
        return 'Value must be smaller than 100';
      }
    } catch (e) {
      print(e);
      return 'Please enter a valid number';
    }

    return null;
  }

  String? validateBedexBatLvl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your BedexBatLvl';
    }

    try {
      final intValue = int.parse(value);
      if (intValue >= 100) {
        return 'Value must be smaller than 100';
      }
    } catch (e) {
      print(e);
      return 'Please enter a valid number';
    }

    return null;
  }

  String? validateDiaperValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Diaper Value';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _diaperNumber.text = '10';
    _bedexbatlvlError = '95';
    _wetBatlvl.text = '67';
    //
   _bedex_bluetooth = true;
   _gatewayOnline = true;
   _hold_button = true;
   _wakeup = true;
   _rolling = true;
   _ncall = true;
   _wetsafe_bluetooth_connected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
              child: const Text(
            'Test App',
            style: TextStyle(letterSpacing: 12, fontSize: 20),
          ))),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 202, 206, 207),
              Color.fromARGB(255, 88, 53, 192),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _gatewayId,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Enter your GateWayId',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        hintText: 'Type in...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        filled: true,
                        fillColor: Color.fromARGB(255, 22, 22, 22),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        errorText: _gatewayIdError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _gatewayIdError = validateGatewayId(value);
                        });
                      },
                      validator: validateGatewayId,
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      controller: _bedexId,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Enter your BedexId',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        hintText: 'Type in...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        filled: true,
                        fillColor: Color.fromARGB(255, 22, 22, 22),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        errorText: _bedexIdError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _bedexIdError = validateBedexId(value);
                        });
                      },
                      validator: validateBedexId,
                    ),
                    SizedBox(height: 30), // Add space between the TextFormField widgets
                    TextFormField(
                      controller: _bedexBatlvl,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Enter your BedexBatLvl',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        hintText: 'Type in...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        filled: true,
                        fillColor: Color.fromARGB(255, 22, 22, 22),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        errorText: _bedexbatlvlError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _bedexbatlvlError = validateBedexBatLvl(value);
                        });
                      },
                      validator: validateBedexBatLvl,
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      controller: _wetBatlvl,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Enter your WetBatLvl',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        hintText: 'Type in...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        filled: true,
                        fillColor: Color.fromARGB(255, 22, 22, 22),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        errorText: _wetbatlvlError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _wetbatlvlError = validateWetBatLvl(value);
                        });
                      },
                      validator: validateBedexBatLvl,
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      controller: _diaperNumber,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Enter your Diaper Value',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        hintText: 'Type in...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        filled: true,
                        fillColor: Color.fromARGB(255, 22, 22, 22),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        errorText: _diaperError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _diaperError = validateDiaperValue(value);
                        });
                      },
                      validator: validateDiaperValue,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Hold_Button',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    //hold button
                    AnimatedTogglee(
                      values: ['True', 'False'], // Labels for the two states.
                      onToggleCallback: (value) {
                        print(value);
                        setState(() {
                          _hold_button = value;
                        });
                      },
                    ),
                    //sssssssssssssssssssssssssss
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Ncall',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: AnimatedTogglee(
                                  values: [
                                    'True',
                                    'False'
                                  ], // Labels for the two states.
                                  onToggleCallback: (value) {
                                    print(value);
                                    setState(() {
                                      _ncall = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Rolling',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              AnimatedTogglee(
                                values: [
                                  'True',
                                  'False'
                                ], // Labels for the two states.
                                onToggleCallback: (value) {
                                  print(value);
                                  setState(() {
                                    _rolling = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Wake_Up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              AnimatedTogglee(
                                values: [
                                  'True',
                                  'False'
                                ], // Labels for the two states.
                                onToggleCallback: (value) {
                                  print(value);
                                  setState(() {
                                    _wakeup = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Gateway_Online',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              AnimatedTogglee(
                                values: [
                                  'True',
                                  'False'
                                ], // Labels for the two states.
                                onToggleCallback: (value) {
                                  print(value);
                                  setState(() {
                                    _gatewayOnline = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Bedex_Bluetooth',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              AnimatedTogglee(
                                values: [
                                  'True',
                                  'False'
                                ], // Labels for the two states.
                                onToggleCallback: (value) {
                                  print(value);
                                  setState(() {
                                    _bedex_bluetooth = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Wetsafe_Bluetooth',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              AnimatedTogglee(
                                values: [
                                  'True',
                                  'False'
                                ], // Labels for the two states.
                                onToggleCallback: (value) {
                                  print(value);
                                  setState(() {
                                    _wetsafe_bluetooth_connected = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: _ImacsTest,
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Set the button's background color
                        onPrimary: Colors.white, // Set the text color
                        elevation: 2, // Add elevation to create a shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              40.0), // Add rounded corners
                        ),
                        minimumSize: Size(150, 50),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 16, // Set the font size
                          fontWeight: FontWeight.bold, // Set font weight
                        ),
                      ),
                    ),
                    SizedBox(height: 5,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
