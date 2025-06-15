import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController(); // Controlador para o campo de valor
  String _fromCurrency = 'BRL'; // Moeda de origem padrão
  String _toCurrency = 'USD'; // Moeda de destino padrão
  double _convertedAmount = 0.0; // Valor convertido

  // Mapa com taxas de câmbio fixas (simples, apenas para demonstração)
  final Map<String, double> _exchangeRates = {
    'USD': 1.0, // Base para o cálculo
    'EUR': 0.92, // 1 USD = 0.92 EUR (exemplo)
    'BRL': 5.20, // 1 USD = 5.20 BRL (exemplo)
  };

  // Lista de moedas disponíveis para seleção
  final List<String> _currencies = ['USD', 'EUR', 'BRL'];

  // Função para realizar a conversão
  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text); // Tenta converter o texto para double

    if (amount == null || amount <= 0) {
      // Exibe um alerta se o valor for inválido
      _showAlert('Valor Inválido', 'Por favor, insira um valor numérico positivo para a conversão.');
      return;
    }

    if (_fromCurrency == _toCurrency) {
      // Se as moedas forem as mesmas, o valor convertido é o próprio valor de entrada
      setState(() {
        _convertedAmount = amount;
      });
      return;
    }

    // Lógica de conversão:
    // 1. Converte o valor de origem para a moeda base (USD)
    final double amountInUsd = amount / _exchangeRates[_fromCurrency]!;
    // 2. Converte o valor da moeda base (USD) para a moeda de destino
    final double finalAmount = amountInUsd * _exchangeRates[_toCurrency]!;

    setState(() {
      _convertedAmount = finalAmount; // Atualiza o valor convertido
    });
  }

  // Função para exibir um diálogo de alerta
  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose(); // Libera o controlador quando o widget é descartado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.blueGrey, Colors.teal], // Gradiente de cores
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView( // Permite rolagem se o conteúdo for muito grande
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: Colors.white.withOpacity(0.95),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Valor a Converter',
                              hintText: 'Ex: 100.00',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.monetization_on),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('De:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  DropdownButton<String>(
                                    value: _fromCurrency,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _fromCurrency = newValue!;
                                      });
                                    },
                                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward, size: 30, color: Colors.blueGrey),
                              Column(
                                children: [
                                  const Text('Para:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  DropdownButton<String>(
                                    value: _toCurrency,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _toCurrency = newValue!;
                                      });
                                    },
                                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            onPressed: _convertCurrency,
                            icon: const Icon(Icons.change_circle),
                            label: const Text('Converter', style: TextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey[700],
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            _convertedAmount == 0.0
                                ? 'Resultado: 0.00 $_toCurrency'
                                : 'Resultado: ${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
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