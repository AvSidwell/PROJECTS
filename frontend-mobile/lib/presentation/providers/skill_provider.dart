import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/skill_local_datasource.dart';
import '../../data/repositories/skill_repository_impl.dart';
import '../../domain/entities/skill.dart';
import '../../domain/repositories/skill_repository.dart';

// Infrastructure providers – override sharedPrefsProvider in main.dart
final sharedPrefsProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('Override sharedPrefsProvider in main()'),
);

final skillLocalDatasourceProvider = Provider<SkillLocalDatasource>(
  (_) => SkillLocalDatasource(),
);

final skillRepositoryProvider = Provider<SkillRepository>(
  (ref) => SkillRepositoryImpl(ref.watch(skillLocalDatasourceProvider)),
);

final allSkillsProvider = FutureProvider<List<Skill>>(
  (ref) => ref.watch(skillRepositoryProvider).getAllSkills(),
);

final skillByIdProvider = FutureProvider.family<Skill?, String>(
  (ref, id) => ref.watch(skillRepositoryProvider).getSkillById(id),
);
