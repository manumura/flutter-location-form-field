import 'package:flutter/material.dart';

import './location_data.dart';
import './location_form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Map<String, dynamic> _formData = {
    'title': null,
    'location': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              child: Column(
                children: <Widget>[
                  _buildTitleTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildLocationField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      focusNode: _titleFocusNode,
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: 'initial',
      validator: (String value) {
        print('validator title');
        if (value.isEmpty || value.length < 3) {
          return 'Title is required and should be 3+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildLocationField() {
    return LocationFormField(
      initialValue: null,
      validator: (LocationData value) {
        print('validator location');
        if (value.address == null || value.address.isEmpty) {
          return 'Please choose a location';
        }
      },
      onSaved: (LocationData value) {
        print('location saved: $value');
        _formData['location'] = value;
      },
    ); // LocationFormField
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
          child: Text('Save'),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () => _submitForm(),
        );
  }

  void _submitForm() {

    print('formdata : $_formData');

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    print('formdata : $_formData');
  }
}
