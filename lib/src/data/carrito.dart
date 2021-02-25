import 'package:hive/hive.dart';

part 'carrito.g.dart';

@HiveType(typeId: 1)
class CarritoData{

  @HiveField(0)
  int codProd;

  @HiveField(1)
  String nomProd;

  @HiveField(2)
  String codEmp;

  @HiveField(3)
  String imgProd;

  @HiveField(4)
  String cantPro;

  @HiveField(5)
  String codUniPrec;

  @HiveField(6)
  String valPrecUnit;

  @HiveField(7)
  String descUniProd;

  @HiveField(8)
  String rucEmp;

  @HiveField(9)
  String nombreEmp;
}