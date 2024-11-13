import 'package:consumption_record/db_consumption/consumption_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConsumption extends GetxService {
  late Database dbBase;

  Future<DBConsumption> init() async {
    await createConsumptionDB();
    return this;
  }

  createConsumptionDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'consumption.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createConsumptionTable(db);
    });
  }

  createConsumptionTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS consumption (id INTEGER PRIMARY KEY, createdTime TEXT, amount TEXT, remark TEXT, star INTEGER)');
  }

  insertData(ConsumptionEntity entity) async {
    final id = await dbBase.insert('consumption', {
      'createdTime': entity.createdTime.toIso8601String(),
      'amount': entity.amount,
      'remark': entity.remark,
      'star': entity.star,
    });
    return id;
  }

  updateData(ConsumptionEntity entity) async {
    await dbBase.update(
        'consumption',
        {
          'amount': entity.amount,
          'remark': entity.remark,
          'star': entity.star,
        },
        where: 'id = ?',
        whereArgs: [entity.id]);
  }

  cleanConsumptionData() async {
    await dbBase.delete('consumption');
  }

  Future<List<ConsumptionEntity>> getAllData(
      {bool? isDateAsc,
      bool? isStarAsc,
      bool? isAmountAsc}) async {
    var result = await dbBase.query('consumption');
    var list = <ConsumptionEntity>[];
    list = result.map((e) => ConsumptionEntity.fromJson(e)).toList();
    if (isDateAsc == true) {
      list.sort((a, b) => a.createdTime.compareTo(b.createdTime));
    } else if (isDateAsc == false) {
      list.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    }
    if (isStarAsc == true) {
      list.sort((a, b) => a.star.compareTo(b.star));
    } else if (isStarAsc == false) {
      list.sort((a, b) => b.star.compareTo(a.star));
    }
    if (isAmountAsc == true) {
      list.sort((a, b) {
        return (num.parse(b.amount) > num.parse(a.amount) ? 1 : -1);
      });
    } else if (isAmountAsc == false) {
      list.sort((a, b) {
        return (num.parse(a.amount) > num.parse(b.amount) ? 1 : -1);
      });
    }
    return list;
  }

  Future<List<ConsumptionEntity>> queryConsumptionByDateRange(DateTime startDate, DateTime endDate) async {
    final List<Map<String, dynamic>> maps = await dbBase.query(
      'consumption',
      where: 'createdTime >= ? AND createdTime <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return ConsumptionEntity.fromJson(maps[i]);
    });
  }


}
