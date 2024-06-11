import 'package:minitalk/models/base_model.dart';
import 'package:minitalk/repository/database_helper.dart';

abstract class DatabaseRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String table;

  DatabaseRepository({
    required this.table,
  });

  Future<List<BaseModel>> find(Function(dynamic) function, {String? where, List<Object?>? whereArgs, String? orderBy}) async {
    return function.call(await _databaseHelper.find(table, where: where, whereArgs: whereArgs, orderBy: orderBy));
  }

  Future<int> insert(BaseModel model) async {
    return await _databaseHelper.insert(table, model.toMap());
  }

  Future<void> insertAll(List<BaseModel> models) async {
    for (var model in models) {
      await _databaseHelper.insert(table, model.toMap());
    }
  }

  Future<int> update(BaseModel model) async {
    return await _databaseHelper.update(table, model.toMap());
  }

  Future<int> delete(BaseModel model) async {
    return await _databaseHelper.delete(table, model.toMap());
  }
}
