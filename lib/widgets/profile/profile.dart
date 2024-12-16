import 'package:flutter/material.dart';
import 'package:flutter_template/models/trainer.dart';
import 'package:flutter_template/providers/trainer.dart';
import 'package:flutter_template/providers/tab_navigator.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int revisitCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer Profile'),
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: TrainerForm()
            // child: Center(child: Text('Profile Page')),
          )
        ),
      ),
    );
  }
}

class TrainerForm extends StatefulWidget {
  const TrainerForm({super.key});

  @override
  State<TrainerForm> createState() => _TrainerFormState();
}

class _TrainerFormState extends State<TrainerForm> {
  final _formKey = GlobalKey<FormState>();
  final _controlledFieldController = TextEditingController();
  
  String controlFieldLabel = 'Controlled Field';
  String? favoritePokemon;
  String? name;
  String? email;

  @override
  void dispose() {
    _controlledFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controlledFieldController.text = controlFieldLabel;
    _controlledFieldController.addListener(() {
      setState(() {
        controlFieldLabel = _controlledFieldController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Trainer Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your trainer name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                onSaved: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address.';
                  }
                  if (value.contains('@') == false) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Text(controlFieldLabel)),
                  Expanded(child: TextFormField(
                    controller: _controlledFieldController,
                    decoration: const InputDecoration(
                      labelText: 'Controlled Field',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value.';
                      }
                      return null;
                    },
                  ))
                ],
              ),
              DropdownButtonFormField<String>(
                onChanged: (value) {
                  favoritePokemon = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Favorite Pokemon',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Pikachu',
                    child: Text('Pikachu'),
                  ),
                  DropdownMenuItem(
                    value: 'Charmander',
                    child: Text('Charmander'),
                  ),
                  DropdownMenuItem(
                    value: 'Squirtle',
                    child: Text('Squirtle'),
                  ),
                  DropdownMenuItem(
                    value: 'Bulbasaur',
                    child: Text('Bulbasaur'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a favorite Pokemon.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: const Text('Can Only show Controlled Fields before submission'),
                      content: Text('Controlled Field - ${_controlledFieldController.text}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }, 
                          child: const Text('Close')
                        )
                      ]
                    );
                  });
                }, 
                child: const Text('Preview')
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && favoritePokemon != null) {
                      
                      // called onSaved on all Fields
                      _formKey.currentState!.save(); 

                      final trainer = TrainerModel(
                        name: name!,
                        email: email!,
                        favoritePokemon: favoritePokemon!,
                      );
                      context.read<TrainerProvider>().setTrainer(trainer);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(width: 8),
                          Text('Processing Data...'),
                        ],
                      )),
                    ).closed.then((reason) {
                      if (context.mounted) {
                        context.read<TabNavigatorProvider>().setTabIndex(0);
                      }
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          )
        ),
      ]
    );
  }
}