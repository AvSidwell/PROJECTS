import '../../../domain/entities/skill.dart';
import '../../seed/handstand_data.dart';

class SkillLocalDatasource {
  Future<List<Skill>> getAllSkills() async => allSkills;

  Future<Skill?> getSkillById(String id) async {
    try {
      return allSkills.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
