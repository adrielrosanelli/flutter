# logica

Projeto focado em teste de componentes, layout e funcionalidades

## TODO List

[X]Botão show no campo de senha;
[X]Validação do e-mail;
[X]Criação do formulario de cadastro;
[]Criação do banco de dados(firebase);
    []Login Automático,
        []Login Offline,

[X]Melhorar Tela Login



Comandos de atualização de repositório:
flutter clean - Limpa as dependências
flutter packages get - baixa e instala as dependências
flutter pub upgrade - atualiza as dependências

backup:
  // var _recuperaValor;

  // _write(String text) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/usuario.txt');
  //   await file.writeAsString(text);
  // }

  // Future<String> _read() async {
  //   String text;
  //   try {
  //     final Directory directory = await getApplicationDocumentsDirectory();
  //     final File file = File('${directory.path}/usuario.txt');
  //     text = await file.readAsString();
  //     setState(() {
  //     _recuperaValor = text.split(" ");
  //       email = _recuperaValor[0].toString();
  //       senha = _recuperaValor[1].toString();
  //       print(email);
  //     print(senha);
  //       email.isNotEmpty && senha.isNotEmpty
  //           ? _submit()
  //           : print('Usuario ou senha invalido(s)');
  //     });

  //   } catch (e) {
  //     print("Couldn't read file");
  //   }

  //   return text;
  // }