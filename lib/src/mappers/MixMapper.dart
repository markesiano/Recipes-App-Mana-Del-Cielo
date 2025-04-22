import 'dart:math';

import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mix.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mixer.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Tool.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/interfaces/IMapper.dart';
import 'package:recipes_app_mana_del_cielo/src/mappers/DTOs/MixRequestDTO.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Ingredient.dart';

class MixMapper extends IMapper<MixRequestDTO, Mix> {
  @override
  Mix ToEntity(MixRequestDTO dto) {
    return Mix(
      id: Random().nextInt(100),
      title: dto.title,
      description: dto.description,
      ingredients: dto.ingredients
          .map((e) => Ingredient(id: e.id, name: e.name, quantity: e.quantity))
          .toList(),
      mixer: Mixer(
        id: dto.mixer.id,
        name: dto.mixer.name,
        description: dto.mixer.description,
        tool: Tool(
          id: dto.mixer.tool.id,
          name: dto.mixer.tool.name,
          description: dto.mixer.tool.description,
        ),
      ),
      minutes: dto.minutes,
      notes: dto.notes,
    );
  }
}
