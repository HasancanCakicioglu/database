// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Car.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 1;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car()
      ..model = fields[0] as String
      ..price = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
