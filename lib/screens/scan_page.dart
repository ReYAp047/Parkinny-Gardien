import 'package:easy_park_gardien/screens/fail_page.dart';
import 'package:easy_park_gardien/screens/success_page.dart';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;

import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

String inputFiled = "";

bool b = true;

void searchReservation(String mat) async {
  WidgetsFlutterBinding.ensureInitialized();


}





class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => TextRecognitionState(),
        child: const TextRecognitionPage(),
      ),
    );
  }
}

class TextRecognitionPage extends StatefulWidget {
  const TextRecognitionPage({Key? key}) : super(key: key);

  @override
  _TextRecognitionPageState createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  TextRecognition? _textRecognition = TextRecognition();
  @override
  void dispose() {
    _textRecognition?.dispose();
    super.dispose();
  }

  Future<void> _startRecognition(InputImage image) async {
    TextRecognitionState state = provider.Provider.of(context, listen: false);

    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _textRecognition?.process(image);
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return InputCameraView(
      mode: InputCameraMode.gallery,
      title: 'Scan immatriculation',
      onImage: _startRecognition,
      overlay: Consumer<TextRecognitionState>(
        builder: (_, state, __) {
          if (state.isNotEmpty) {
            inputFiled = state.text.characters.toString();
            myController.text = state.text.characters.toString();
          }else{
            inputFiled ="Erreur: Merci de tapez manuellement";
            myController.text = state.text.characters.toString();
          }

          return Container(
            padding: EdgeInsets.all(60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: TextFormField(
              controller: myController,
              onChanged: (value) {
                inputFiled = value;
              },
              decoration: InputDecoration(
                hintText: "Tapez ici l'immatriculation ou scanner le",

                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: ()  async {
                    RegExp regExp = RegExp(r'^\d+\D+\d+$');
                    if (regExp.hasMatch(inputFiled)) {
                      //erreur
                     // if(inputFiled != "247TU9999"){



                      var now = DateTime.now();
                      var formatter = DateFormat('HH:mm');
                      var formattedTime = formatter.format(now);

                      await Supabase.initialize(
                        url: "https://cjeegjzamsxuqmnosuhr.supabase.co",
                        anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNqZWVnanphbXN4dXFtbm9zdWhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY3NDMzMzAsImV4cCI6MTk5MjMxOTMzMH0._3QMaBP_CYAT61S7VdQdwxdUsxIHA9mI-MGMuDaOtS4",
                      );

                      String dateString = DateFormat('dd-MM-yyyy').format(now);

                      var response = await Supabase.instance.client
                          .from('reservation_reservation')
                          .select()
                          .eq('Matricule', inputFiled)
                          .gte('Date_Sortie', formattedTime)
                       //   .eq('Date', dateString)
                          .execute();

                      var data = response.data;
                      if (data.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FailPage(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SuccessPage(),
                          ),
                        );
                      }


                      // Perform some action
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Erreur Format"),
                            content: const Text("Ce format n'est pas Valide"),
                            actions: [
                              ElevatedButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      // Show an error message
                    }

                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextRecognitionState extends ChangeNotifier {
  InputImage? _image;
  RecognizedText? _data;
  bool _isProcessing = false;

  InputImage? get image => _image;
  RecognizedText? get data => _data;
  String get text => _data!.text;
  bool get isNotProcessing => !_isProcessing;
  bool get isNotEmpty => _data != null && text.isNotEmpty;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set data(RecognizedText? data) {
    _data = data;
    notifyListeners();
  }
}
