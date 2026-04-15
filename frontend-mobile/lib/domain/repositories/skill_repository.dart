import '../entities/skill.dart';

abstract class SkillRepository {
  Future<List<Skill>> getAllSkills();
  Future<Skill?> getSkillById(String id);
}
