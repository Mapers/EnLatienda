// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrito.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarritoDataAdapter extends TypeAdapter<CarritoData> {
  @override
  final int typeId = 1;

  @override
  CarritoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarritoData()
      ..codProd = fields[0] as int
      ..nomProd = fields[1] as String
      ..codEmp = fields[2] as String
      ..imgProd = fields[3] as String
      ..cantPro = fields[4] as String
      ..codUniPrec = fields[5] as String
      ..valPrecUnit = fields[6] as String
      ..descUniProd = fields[7] as String
      ..rucEmp = fields[8] as String
      ..nombreEmp = fields[9] as String;
  }

  @override
  void write(BinaryWriter writer, CarritoData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.codProd)
      ..writeByte(1)
      ..write(obj.nomProd)
      ..writeByte(2)
      ..write(obj.codEmp)
      ..writeByte(3)
      ..write(obj.imgProd)
      ..writeByte(4)
      ..write(obj.cantPro)
      ..writeByte(5)
      ..write(obj.codUniPrec)
      ..writeByte(6)
      ..write(obj.valPrecUnit)
      ..writeByte(7)
      ..write(obj.descUniProd)
      ..writeByte(8)
      ..write(obj.rucEmp)
      ..writeByte(9)
      ..write(obj.nombreEmp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarritoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
