import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Estacionamento Table

const String parkTable = 'ESTACIONAMENTO';
const String parkingSpace = 'NUMERO_VAGA';
const String vacancyFilled = 'PREENCHIDA';
const String dateOpen = 'DATA_ENTRADA';
const String dateOut = 'DATA_SAIDA';

//Historico Table
const String historicTable = 'HISTORICO';
const String idHistoric = 'ID';
const String historicParkingSpace = 'NUMERO_VAGA';
const String costumerHistoric = 'CLIENTE';
const String historicDateOpen = 'DATA_ENTRADA';
const String historicDateOut = 'DATA_SAIDA';

class BancoDeDados {
  BancoDeDados._privateConstructor();
  static final BancoDeDados instance = BancoDeDados._privateConstructor();

  Database? db;

  Future<Database> _initdatabase() async {
    String caminhoDoBanco = await getDatabasesPath();
    String _banco = 'Estacionamento.db';
    String path = join(caminhoDoBanco, _banco);
    return await openDatabase(path, version: 1, onCreate: criarBanco);
  }

  Future criarBanco(Database db, int novaVersao) async {
    List<String> queries = [
      """CREATE TABLE $parkTable($parkingSpace INTEGER PRIMARY KEY,
      $vacancyFilled INTEGER, $dateOpen TEXT, $dateOut TEXT)""",
      """CREATE TABLE $historicTable($idHistoric INTEGER PRIMARY KEY, 
      $historicParkingSpace INTEGER, $costumerHistoric TEXT,
      $historicDateOpen TEXT, $historicDateOut TEXT, 
      FOREIGN KEY ($historicParkingSpace)
      REFERENCES $parkTable($parkingSpace))""",
    ];
    for (String query in queries) {
      await db.execute(query);
    }
    await db.close();
  }

  Future insertVagas(Map<String, dynamic> row) async {
    Database db = await _initdatabase();
    await db.insert(parkTable, row);
    await db.close();
  }

  Future<dynamic> updateVagas(Map<String, dynamic> row, var vaga) async {
    Database db = await _initdatabase();
    await db
        .update(parkTable, row, where: '$parkingSpace = ?', whereArgs: [vaga]);
    await db.close();
  }

  Future insertHistorico(Map<String, dynamic> row) async {
    Database db = await _initdatabase();
    var id = await db.insert(historicTable, row);
    await db.close();
    return id;
  }

  Future<dynamic> updateHistorico(Map<String, dynamic> row, var id) async {
    Database db = await _initdatabase();
    await db
        .update(historicTable, row, where: '$idHistoric = ?', whereArgs: [id]);
    await db.close();
  }

  Future getVagas(String sql) async {
    Database db = await _initdatabase();
    var result = await db.rawQuery(sql);
    db.close();
    return result;
  }

  Future getHistorico() async {
    Database db = await _initdatabase();
    var result = await db.rawQuery('select * from $historicTable');
    db.close();
    return result;
  }

  Future getIdHistorico(var vaga) async {
    Database db = await _initdatabase();
    List result = await db.rawQuery(
        'select * from $historicTable where $historicParkingSpace = ? order by $idHistoric',
        [vaga]);
    db.close();
    return result.last;
  }

  Future deletarBanco() async {
    String caminhoDoBanco = await getDatabasesPath();
    String _banco = 'MidasMobile.db';
    String path = join(caminhoDoBanco, _banco);
    deleteDatabase(path);
  }
}
