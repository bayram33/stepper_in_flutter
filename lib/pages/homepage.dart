import "package:flutter/material.dart";
import "package:flutter/services.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentState = 0;
  String? name, surname, password;
  List<Step>? _allSteps;

  var keyName = GlobalKey<FormFieldState>();
  var keySurname = GlobalKey<FormFieldState>();
  var keyPassword = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _allSteps = allSteps();
  }

  @override
  Widget build(BuildContext context) {
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Center(
          child: Text(
            "Example",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          steps: _allSteps!,
          currentStep: _currentState,
          /* onStepTapped: (value) {
            setState(() {
              _currentState = value;
            });
          }, */
          onStepContinue: () {
            setState(() {
              forwardButton();
            });
          },
          onStepCancel: () {
            if (_currentState > 0) {
              setState(() {
                _currentState--;
              });
            }
          },
        ),
      ),
    );
  }

  List<Step> allSteps() {
    List<Step> steps = [
      Step(
        title: const Text("Name title"),
        subtitle: const Text("Name subtitle"),
        state: StepState.indexed,
        content: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextFormField(
            key: keyName,
            decoration: const InputDecoration(
              hintText: "deneme1",
              labelText: "test1",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.length < 5) {
                return "at least 5 ";
              }
              return null;
            },
            onSaved: (newValue) {
              setState(() {
                name = newValue;
              });
            },
          ),
        ),
      ),
      Step(
        title: const Text("Surname title"),
        subtitle: const Text("Surname subtitle"),
        state: StepState.indexed,
        content: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextFormField(
            key: keySurname,
            decoration: const InputDecoration(
              hintText: "deneme2",
              labelText: "test2",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.length < 6) {
                return " at least 6";
              }
              return null;
            },
            onSaved: (newValue) {
              setState(() {
                surname = newValue;
              });
            },
          ),
        ),
      ),
      Step(
        title: const Text("Password title"),
        state: StepState.indexed,
        subtitle: const Text("Password subtitle"),
        content: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextFormField(
            key: keyPassword,
            decoration: const InputDecoration(
              hintText: "deneme3",
              labelText: "test3",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.length < 7) {
                return "at least 7 buddy";
              }
              return null;
            },
            onSaved: (newValue) {
              setState(() {
                password = newValue;
              });
            },
          ),
        ),
      ),
    ];

    return steps;
  }

  void forwardButton() {
    switch (_currentState) {
      case 0:
        if (keyName.currentState!.validate()) {
          keyName.currentState!.save();
          _currentState = 1;
        }
        break;
      case 1:
        if (keySurname.currentState!.validate()) {
          keyName.currentState!.save();
          _currentState = 2;
        }
        break;
      case 2:
        if (keyPassword.currentState!.validate()) {
          keyName.currentState!.save();
        }
        break;
    }
  }
}
