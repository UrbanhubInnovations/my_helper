import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  @HiveType(typeId: 0, adapterName: 'SettingsAdapter')
  const factory SettingsModel({
    @HiveField(0, defaultValue: false) @Default(false) bool hasLoggedIn,
    @HiveField(1, defaultValue: false) @Default(false) bool hasOnboarded,
    @HiveField(2, defaultValue: false) @Default(false) bool isAlarmRinging,
  }) = _SettingsModel;
}
