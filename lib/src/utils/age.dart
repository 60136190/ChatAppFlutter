
import 'package:task1/src/models/picker_model.dart';

Map<int, String> ageMap;

void initAgeMap(List<PickerModel> metadata) {
  ageMap = Map<int, String>.fromIterable(metadata,
    key: (item) => item.value,
    value: (item) => item.name
  );
}

String stringRepresentationOfAgeID(int ageID) {
  return ageMap[ageID] ?? '';
}