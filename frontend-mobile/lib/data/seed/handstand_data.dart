import '../../domain/entities/drill.dart';
import '../../domain/entities/hurdle.dart';
import '../../domain/entities/progression_stage.dart';
import '../../domain/entities/skill.dart';

// ─── Drills ─────────────────────────────────────────────────────────────────

const _wristCircles = Drill(
  id: 'drill_wrist_circles',
  name: 'Wrist Circles',
  description: 'Warm up the wrist joints and increase blood flow before any weight-bearing.',
  steps: [
    'Extend both arms in front at shoulder height.',
    'Make loose fists.',
    'Rotate wrists clockwise for 20 reps.',
    'Reverse direction for another 20 reps.',
    'Shake hands out gently between sets.',
  ],
  sets: '2 sets',
  reps: '20 reps each direction',
  tip: 'Move slowly — this is warm-up, not exercise.',
);

const _wristFlexorStretch = Drill(
  id: 'drill_wrist_flexor_stretch',
  name: 'Wrist Flexor Stretch',
  description: 'Lengthen the flexor muscles along the inside of the forearm.',
  steps: [
    'Extend one arm forward, palm facing up.',
    'With the other hand, gently pull fingers toward the floor.',
    'Hold for 30 seconds, feeling the stretch along the forearm.',
    'Switch arms.',
  ],
  sets: '3 sets',
  reps: '30s per arm',
  tip: 'Never stretch into pain — discomfort is fine, sharp pain is not.',
  durationSeconds: 30,
);

const _wristExtensionHold = Drill(
  id: 'drill_wrist_extension_hold',
  name: 'Wrist Extension Hold',
  description: 'Progressively load the wrist in extension — the position used in handstands.',
  steps: [
    'Come to hands and knees on the floor.',
    'Place palms flat, fingers pointing forward.',
    'Shift weight forward until it is directly over your wrists.',
    'Hold the position, keeping wrists fully open.',
    'Reduce weight if you feel sharp pain.',
  ],
  sets: '3 sets',
  reps: '30–60s hold',
  tip: 'Work toward 60s with zero discomfort before moving on.',
  durationSeconds: 60,
);

const _knucklePushUps = Drill(
  id: 'drill_knuckle_pushups',
  name: 'Knuckle Push-Ups',
  description: 'Strengthen wrists and forearms while reducing extension load.',
  steps: [
    'Come to a push-up position on your fists, knuckles down.',
    'Keep wrists straight and elbows close to the body.',
    'Lower chest to an inch from the floor.',
    'Press back up to the start.',
  ],
  sets: '3 sets',
  reps: '8–10 reps',
);

const _hollowBodyHold = Drill(
  id: 'drill_hollow_body',
  name: 'Hollow Body Hold',
  description: 'Build the core tension that defines handstand body shape.',
  steps: [
    'Lie on your back, arms extended overhead.',
    'Press your lower back firmly into the floor.',
    'Lift your shoulders and legs off the ground simultaneously.',
    'Hold the shape — no daylight between lower back and floor.',
    'Keep your chin slightly tucked, eyes toward your knees.',
  ],
  sets: '3 sets',
  reps: '20–30s hold',
  tip: 'If your back lifts, raise your legs higher. Build duration over weeks.',
  durationSeconds: 30,
);

const _hollowBodyRocks = Drill(
  id: 'drill_hollow_rocks',
  name: 'Hollow Body Rocks',
  description: 'Dynamic version of the hollow hold — teaches controlled tension.',
  steps: [
    'Get into a hollow body position.',
    'Gently rock your body forward and backward.',
    'Maintain the hollow shape throughout — no breaking the curve.',
    'Keep breathing.',
  ],
  sets: '3 sets',
  reps: '15 rocks',
);

const _standardPlank = Drill(
  id: 'drill_plank',
  name: 'Standard Plank',
  description: 'Build shoulder stability and full-body tension.',
  steps: [
    'Place hands shoulder-width apart, arms straight.',
    'Extend legs back, toes on the floor.',
    'Create a straight line from head to heel.',
    'Squeeze glutes, brace core, push floor away with hands.',
    'Hold without letting hips sag or rise.',
  ],
  sets: '3 sets',
  reps: '45–90s hold',
  durationSeconds: 60,
);

const _pikeHold = Drill(
  id: 'drill_pike_hold',
  name: 'Standing Pike Hold',
  description: 'Develop hamstring flexibility and shoulder protraction for inversion.',
  steps: [
    'Stand with feet hip-width apart.',
    'Fold forward and place hands flat on the floor.',
    'Walk hands forward until your hips are above your shoulders.',
    'Press through your hands — push the floor away.',
    'Hold with a flat back and active shoulders.',
  ],
  sets: '3 sets',
  reps: '30–60s hold',
  durationSeconds: 45,
);

const _boxPike = Drill(
  id: 'drill_box_pike',
  name: 'Elevated Pike (Box Pike)',
  description: 'Get closer to full inversion — feet on a raised surface.',
  steps: [
    'Place feet on a chair, box, or couch.',
    'Walk hands back until hips stack above shoulders.',
    'Press actively through the floor with straight arms.',
    'Squeeze core and keep a straight spine.',
    'Hold position.',
  ],
  sets: '3 sets',
  reps: '30–60s hold',
  tip: 'Use a higher surface as you get stronger.',
  durationSeconds: 45,
);

const _chestToWallKickUp = Drill(
  id: 'drill_chest_wall_kickup',
  name: 'Chest-to-Wall Kick-Up',
  description: 'Enter the inverted position with wall support — your back faces out.',
  steps: [
    'Face away from the wall, hands 6–8 inches from it.',
    'Kick one leg up and let the other follow.',
    'Allow your chest to rest gently against the wall.',
    'Stack shoulders over wrists, engage core.',
    'Hold the position and breathe.',
  ],
  sets: '3 sets',
  reps: '30–60s hold',
  tip: 'Aim for chest to touch the wall lightly — do not banana arch.',
  durationSeconds: 60,
);

const _shoulderTaps = Drill(
  id: 'drill_shoulder_taps',
  name: 'Wall Shoulder Taps',
  description: 'Begin shifting weight and building single-arm stability in handstand.',
  steps: [
    'Get into a chest-to-wall handstand.',
    'Slowly shift weight onto your right hand.',
    'Lift left hand and tap your left shoulder.',
    'Replace hand. Repeat on the other side.',
    'Move slowly — control is more important than speed.',
  ],
  sets: '3 sets',
  reps: '6–10 taps per side',
  tip: 'If hips rotate, pause and re-stack before continuing.',
);

const _pirouetteBail = Drill(
  id: 'drill_pirouette_bail',
  name: 'Pirouette Bail Practice',
  description: 'Learn a safe, controlled way to exit a handstand without crashing.',
  steps: [
    'Start in a downward dog or plank position.',
    'Shift your weight to one hand.',
    'Step the opposite foot forward and around in a sweeping motion.',
    'Land softly on both feet.',
    'Drill this 10 times before kicking up to a wall.',
  ],
  sets: '3 sets',
  reps: '10 reps each direction',
  tip: 'This is the most important skill before any freestanding work.',
);

const _kickUpPractice = Drill(
  id: 'drill_kickup',
  name: 'Wall Kick-Up (Face to Wall)',
  description: 'Refine the kick-up movement — the entry point for every handstand.',
  steps: [
    'Face the wall, hands 6 inches away, shoulder-width.',
    'Stagger your feet — one forward (kicker), one back.',
    'Kick the back leg up while pushing off the front.',
    'Stack hips over shoulders, feet reach the wall.',
    'Control the landing — pirouette or step down.',
  ],
  sets: '4 sets',
  reps: '5–8 kick-ups',
  tip: 'One leg leads — do not jump with both feet.',
);

const _fingerPressureBalance = Drill(
  id: 'drill_finger_balance',
  name: 'Wall Finger-Pressure Balance',
  description: 'Learn to use finger pressure to correct balance in real time.',
  steps: [
    'Kick up to a face-to-wall handstand.',
    'Float both feet gently away from the wall.',
    'Use finger pressure to prevent overbalancing.',
    'Return to wall if you fall, reset, repeat.',
    'Work toward 3–5s away from the wall.',
  ],
  sets: '5 sets',
  reps: '3–5s free holds',
  tip: 'The fingers are your steering wheel. Pressing harder brings you back.',
  durationSeconds: 5,
);

const _freestyleHoldDrills = Drill(
  id: 'drill_freestyle_holds',
  name: 'Freestanding Hold Attempts',
  description: 'Build duration and consistency in freestanding handstands.',
  steps: [
    'Kick up from a controlled, consistent spot.',
    'Find your balance point over your wrists.',
    'Use fingers for micro-corrections.',
    'Bail cleanly with pirouette when needed.',
    'Aim to extend hold each session.',
  ],
  sets: '5–8 sets',
  reps: 'Max hold attempts',
  tip: 'Track your best hold per session. Consistency beats one great attempt.',
);

// ─── Stages ──────────────────────────────────────────────────────────────────

const _stage1 = ProgressionStage(
  id: 'stage_wrist_prep',
  skillId: 'skill_handstand',
  order: 1,
  name: 'Wrist Preparation',
  description:
      'Your wrists will support your entire bodyweight in a handstand. '
      'This stage builds the strength, flexibility, and resilience they need.',
  goal: 'Achieve comfortable 60s wrist extension holds with no pain.',
  drills: [_wristCircles, _wristFlexorStretch, _wristExtensionHold, _knucklePushUps],
  successCriteria: 'Complete a 60s wrist extension hold in quadruped with zero pain or discomfort.',
  commonMistakes: [
    'Skipping this stage because it feels "too easy".',
    'Ignoring wrist ache and pushing through pain.',
    'Not warming up wrists before every session.',
  ],
);

const _stage2 = ProgressionStage(
  id: 'stage_hollow_body',
  skillId: 'skill_handstand',
  order: 2,
  name: 'Hollow Body',
  description:
      'The hollow body shape is the foundation of every straight handstand. '
      'You need to own this shape on the floor before you invert it.',
  goal: 'Hold a solid 30-second hollow body with lower back completely flat.',
  drills: [_hollowBodyHold, _hollowBodyRocks],
  successCriteria: '30s hollow hold with lower back pressed flat — no arching, no shaking.',
  commonMistakes: [
    'Letting the lower back lift off the floor.',
    'Holding breath instead of breathing through the tension.',
    'Raising the legs too high to compensate for a weak core.',
  ],
);

const _stage3 = ProgressionStage(
  id: 'stage_plank_pike',
  skillId: 'skill_handstand',
  order: 3,
  name: 'Plank & Pike Strengthening',
  description:
      'Build the shoulder strength and stability needed to hold your bodyweight overhead. '
      'The pike gets your hips over your hands — the key geometry of a handstand.',
  goal: 'Hold a 90s plank and a 60s box pike with active, protracted shoulders.',
  drills: [_standardPlank, _pikeHold, _boxPike],
  successCriteria: '90s plank with straight body + 60s box pike with hips stacked above shoulders.',
  commonMistakes: [
    'Sinking through the shoulders in the plank.',
    'Allowing the hips to drop in the pike.',
    'Bending elbows instead of pressing through straight arms.',
  ],
);

const _stage4 = ProgressionStage(
  id: 'stage_chest_wall',
  skillId: 'skill_handstand',
  order: 4,
  name: 'Chest-to-Wall Handstand',
  description:
      'Your first full inversions. The wall does the balancing — your job is to build '
      'strength and get comfortable being upside down.',
  goal: 'Hold a 60s chest-to-wall handstand with a straight, hollow body.',
  drills: [_chestToWallKickUp],
  successCriteria: '60s chest-to-wall HS with shoulders fully engaged, minimal arch.',
  commonMistakes: [
    'Severe banana arch (hips pushed forward, back curved).',
    'Shrugging shoulders instead of pushing through them.',
    'Looking at the floor instead of slightly at the wall.',
  ],
  holdDurationSeconds: 60,
);

const _stage5 = ProgressionStage(
  id: 'stage_shoulder_taps',
  skillId: 'skill_handstand',
  order: 5,
  name: 'Wall Shoulder Taps',
  description:
      'Begin shifting your centre of gravity onto one arm at a time. '
      'This builds unilateral shoulder strength and teaches hip alignment.',
  goal: '10 clean alternating shoulder taps on the wall.',
  drills: [_chestToWallKickUp, _shoulderTaps],
  successCriteria: '10 alternating shoulder taps without hip rotation or elbow bend.',
  commonMistakes: [
    'Hips rotating away from the wall.',
    'Bending the support arm under load.',
    'Moving too fast — each tap should be deliberate.',
  ],
);

const _stage6 = ProgressionStage(
  id: 'stage_kickup',
  skillId: 'skill_handstand',
  order: 6,
  name: 'Kick-Up Mastery',
  description:
      'Learn to enter the handstand consistently and exit safely. '
      'The kick-up is the gate to freestanding work — master this before anything else.',
  goal: 'Consistent, controlled kick-up to a face-to-wall handstand every attempt.',
  drills: [_pirouetteBail, _kickUpPractice],
  successCriteria: 'Land on the wall cleanly 8 out of 10 attempts. Pirouette bail is automatic.',
  commonMistakes: [
    'Jumping with both feet instead of kicking one leg up.',
    'Bent lead leg on kick-up.',
    'No bail practice — panicking and crashing out.',
    'Hands too far from the wall (more than 8 inches).',
  ],
);

const _stage7 = ProgressionStage(
  id: 'stage_balance_drills',
  skillId: 'skill_handstand',
  order: 7,
  name: 'Balance Drills',
  description:
      'Develop the micro-adjustments of balance. Use the wall as a spotter, '
      'not a crutch — the goal is to spend time away from it.',
  goal: 'Consistent 5-second freestanding holds away from the wall.',
  drills: [_fingerPressureBalance],
  successCriteria: '5s freestanding hold, 3 times in a session, with clean exits.',
  commonMistakes: [
    'Stiff wrists — balance is in the fingers, not the palms.',
    'Holding breath and freezing the body.',
    'Focusing on duration instead of quality.',
    'Not recording attempts for feedback.',
  ],
  holdDurationSeconds: 5,
);

const _stage8 = ProgressionStage(
  id: 'stage_freestanding',
  skillId: 'skill_handstand',
  order: 8,
  name: 'Freestanding Handstand',
  description:
      'The milestone. A 10-second solid hold away from the wall with a clean stacked body. '
      'By now your body knows the shape — your mind just needs to trust it.',
  goal: 'A 10-second solid freestanding handstand with consistent entries.',
  drills: [_kickUpPractice, _fingerPressureBalance, _freestyleHoldDrills],
  successCriteria: '10s freestanding handstand, reproducible, with a clean pirouette exit.',
  commonMistakes: [
    'Overextending through the lower back under pressure.',
    'Panic-kicking the legs when losing balance.',
    'Only practising the hold, never the entry or exit.',
  ],
  holdDurationSeconds: 10,
);

// ─── Hurdles ─────────────────────────────────────────────────────────────────

const _hurdleOverbalancing = Hurdle(
  id: 'hurdle_overbalancing',
  skillId: 'skill_handstand',
  title: 'I keep overbalancing / falling over',
  description:
      'You keep pitching over your hands and crashing out. '
      'This is the most common handstand problem — and it is fixable.',
  causes: [
    'Too much kick momentum — overshooting the balance point.',
    'Not using fingers to brake overbalance.',
    'Stiff, locked wrists.',
    'No pirouette bail, so panic sets in before balance develops.',
  ],
  fixes: [
    'Slow down your kick — less is more. You should barely reach the wall.',
    'Actively press fingertips into the floor to stop forward tipping.',
    'Drill pirouette bails until they are completely automatic.',
    'Practice with a crash mat so fear does not tighten your body.',
  ],
  correctiveExercises: [_pirouetteBail, _fingerPressureBalance],
);

const _hurdleWristPain = Hurdle(
  id: 'hurdle_wrist_pain',
  skillId: 'skill_handstand',
  title: 'My wrists hurt during or after training',
  description:
      'Wrist pain is the number one reason people quit handstand training early. '
      'It almost always comes from doing too much, too soon, without preparation.',
  causes: [
    'Skipping or rushing through wrist prep work.',
    'Sudden volume increase — too many handstands per session.',
    'Wrists are not yet conditioned for full bodyweight.',
    'Poor hand position — fingers not spread, weight not distributed.',
  ],
  fixes: [
    'Stop handstand training until acute pain subsides.',
    'Return to Stage 1 wrist conditioning and stay there for 4–6 weeks.',
    'Try fist handstands to reduce wrist extension angle temporarily.',
    'Spread fingers wide — distribute weight across the whole hand.',
    'Never skip wrist warm-up.',
  ],
  correctiveExercises: [_wristCircles, _wristFlexorStretch, _wristExtensionHold],
);

const _hurdleShoulderMobility = Hurdle(
  id: 'hurdle_shoulder_mobility',
  skillId: 'skill_handstand',
  title: 'I cannot get straight — my back arches',
  description:
      'A banana-back handstand is caused by insufficient shoulder flexion range. '
      'Your arms cannot get fully overhead, so your lower back compensates.',
  causes: [
    'Limited shoulder flexion — arms cannot reach fully vertical overhead.',
    'Tight lats and thoracic spine.',
    'Habit of arching to feel "stable" in the position.',
  ],
  fixes: [
    'Add daily overhead shoulder stretching — doorframe stretch, banded overhead stretch.',
    'Work on thoracic mobility with foam rolling.',
    'Use the chest-to-wall handstand as a diagnostic — the wall gives feedback.',
    'Practice hollow body every day to groove the correct shape.',
  ],
  correctiveExercises: [_hollowBodyHold, _chestToWallKickUp],
);

const _hurdleFearOfFalling = Hurdle(
  id: 'hurdle_fear',
  skillId: 'skill_handstand',
  title: 'I am scared to kick up / afraid of falling',
  description:
      'Fear is a physical block. If you do not have a safe exit, your body will never '
      'fully commit to the movement — and you will never balance.',
  causes: [
    'No reliable bail technique practised.',
    'Previous bad fall or wrist injury.',
    'Training on hard floors without a mat.',
  ],
  fixes: [
    'Drill pirouette exits 20 times before any kick-up attempt.',
    'Use a crash mat or thick yoga mat under your hands.',
    'Train against the wall until trust is fully established — there is no rush.',
    'Have a friend or wall always within reach as a spotter.',
  ],
  correctiveExercises: [_pirouetteBail],
);

const _hurdleAlignment = Hurdle(
  id: 'hurdle_alignment',
  skillId: 'skill_handstand',
  title: 'My body feels crooked / hips are always off',
  description:
      'Misalignment in a handstand usually comes from imbalances built in earlier stages '
      'or from using shoulder taps without controlling the hips.',
  causes: [
    'One shoulder is weaker — weight shifts toward it.',
    'Hip flexibility imbalance causing leg scissoring.',
    'Not practising shoulder taps slowly enough.',
  ],
  fixes: [
    'Film your handstands from the side and front.',
    'Drill wall shoulder taps with a friend watching your hips.',
    'Add single-arm plank holds to identify and close strength gaps.',
    'Squeeze glutes and thighs together to prevent leg drift.',
  ],
  correctiveExercises: [_shoulderTaps, _hollowBodyHold],
);

// ─── Skills ──────────────────────────────────────────────────────────────────

const handstandSkill = Skill(
  id: 'skill_handstand',
  name: 'Handstand',
  subtitle: 'The foundation of gymnastics strength',
  description:
      'A freestanding handstand is the benchmark of upper-body strength and body control. '
      'It requires shoulder mobility, wrist conditioning, core tension, and the ability '
      'to micro-balance — all at once. That is what makes it so rewarding to achieve.',
  whyItsHard:
      'Most people have never loaded full bodyweight through their wrists. '
      'They lack the shoulder flexion to stack correctly, the core strength to hold a hollow position inverted, '
      'and the spatial awareness to balance upside down. '
      'Each of these takes time — but all of them are trainable.',
  difficulty: SkillDifficulty.intermediate,
  prerequisites: [
    'Basic push-up strength (10+ reps)',
    'No active wrist or shoulder injury',
    'Willingness to train consistently, 4–5x per week',
  ],
  stages: [
    _stage1,
    _stage2,
    _stage3,
    _stage4,
    _stage5,
    _stage6,
    _stage7,
    _stage8,
  ],
  hurdles: [
    _hurdleOverbalancing,
    _hurdleWristPain,
    _hurdleShoulderMobility,
    _hurdleFearOfFalling,
    _hurdleAlignment,
  ],
  tags: ['strength', 'balance', 'gymnastics', 'upper body'],
);

// Coming-soon skills

const lSitSkill = Skill(
  id: 'skill_lsit',
  name: 'L-Sit',
  subtitle: 'Pure core and hip flexor strength',
  description:
      'The L-sit is a static hold performed with straight legs held parallel to the floor, '
      'arms locked and supporting the full body. It builds exceptional compression strength.',
  whyItsHard:
      'The combination of hip flexor endurance, tricep strength, and scapular depression needed '
      'to hold the legs horizontal is far more demanding than it appears.',
  difficulty: SkillDifficulty.beginner,
  prerequisites: [
    'Ability to do 10 dips',
    'Basic hip flexor strength',
  ],
  stages: [],
  hurdles: [],
  tags: ['core', 'strength', 'static'],
  status: SkillStatus.comingSoon,
);

const crowPoseSkill = Skill(
  id: 'skill_crow',
  name: 'Crow Pose',
  subtitle: 'Your first arm balance',
  description:
      'Crow pose (Kakasana) is the gateway arm balance — knees resting on triceps, '
      'body tipped forward, feet lifted. It is achievable within weeks with the right approach.',
  whyItsHard:
      'The unfamiliarity of putting weight on your hands and the fear of falling forward '
      'are the primary barriers — not lack of strength.',
  difficulty: SkillDifficulty.beginner,
  prerequisites: [
    'Basic wrist conditioning',
    'Confidence putting weight on hands',
  ],
  stages: [],
  hurdles: [],
  tags: ['balance', 'yoga', 'arm balance'],
  status: SkillStatus.comingSoon,
);

const pullUpSkill = Skill(
  id: 'skill_pullup',
  name: 'Pull-Up',
  subtitle: 'The benchmark of pulling strength',
  description:
      'A strict dead-hang pull-up is the foundation of all upper-body pulling movements '
      'in calisthenics. Once achieved, it opens the door to muscle-ups, levers, and beyond.',
  whyItsHard:
      'Most people lack the lat recruitment and grip endurance to complete a full range pull-up. '
      'The bottom dead-hang position is particularly demanding on the shoulder girdle.',
  difficulty: SkillDifficulty.beginner,
  prerequisites: [
    'No shoulder injury',
    'Ability to hang from a bar for 30s',
  ],
  stages: [],
  hurdles: [],
  tags: ['pulling', 'back', 'strength', 'fundamentals'],
  status: SkillStatus.comingSoon,
);

const pistolSquatSkill = Skill(
  id: 'skill_pistol',
  name: 'Pistol Squat',
  subtitle: 'Single-leg strength and mobility',
  description:
      'A pistol squat is a full single-leg squat — from standing to the bottom, '
      'non-working leg extended forward. It demands balance, ankle mobility, and serious leg strength.',
  whyItsHard:
      'The combination of balance, ankle dorsiflexion, hip mobility, and single-leg strength '
      'is challenging. Most people fail at the bottom due to limited ankle range.',
  difficulty: SkillDifficulty.intermediate,
  prerequisites: [
    'Solid bilateral squat form',
    'Decent ankle mobility',
  ],
  stages: [],
  hurdles: [],
  tags: ['legs', 'balance', 'mobility', 'strength'],
  status: SkillStatus.comingSoon,
);

final allSkills = [handstandSkill, lSitSkill, crowPoseSkill, pullUpSkill, pistolSquatSkill];
