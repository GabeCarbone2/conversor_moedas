import 'package:flutter/material.dart';
import 'screens/currency_converter_screen.dart'; // Importa a tela do conversor

void main() {
  runApp(const MyApp()); // Roda a aplicação
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Cor primária do tema
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Adicionando um tema para os cartões e botões
        cardTheme: CardThemeData( 
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 3,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.blueGrey[700]),
        ),
      ),
      home: const CurrencyConverterScreen(), // Define a tela inicial
      debugShowCheckedModeBanner: false, // Remove a faixa de "Debug"
    );
  }
}