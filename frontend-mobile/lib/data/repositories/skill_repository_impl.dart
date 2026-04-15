import '../../domain/entities/skill.dart';
import '../../domain/repositories/skill_repository.dart';
import '../datasources/local/skill_local_datasource.dart';

class SkillRepositoryImpl implements SkillRepository {
  SkillRepositoryImpl(this._datasource);

  final SkillLocalDatasource _datasource;

  @override
  Future<List<Skill>> getAllSkills() => _datasource.getAllSkills();

  @override
  Future<Skill?> getSkillById(String id) => _datasource.getSkillById(id);
}
