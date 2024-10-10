import 'package:bloc_librari/bloc/color_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi HydratedStorage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  // Jalankan aplikasi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (context) => ColorBloc(), child: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              context.read<ColorBloc>().add(ColorEvent.to_amber);
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              context.read<ColorBloc>().add(ColorEvent.to_light_blue);
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Bloc Library"),
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(builder: (context, color) {
          return AnimatedContainer(
            duration: Duration(seconds: 1),
            width: 100,
            height: 100,
            color: color,
          );
        }),
      ),
    );
  }
}
