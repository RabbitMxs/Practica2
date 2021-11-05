class DotaHeroesModel {
  int? id;
  String? localizedName;
  String? primaryAttr;
  String? attackType;
  List<dynamic>? roles;
  String? img;
  String? icon;
  int? baseHealth;
  num? baseHealthRegen;
  int? baseMana;
  num? baseManaRegen;
  num? baseArmor;
  int? baseMr;
  int? baseAttackMin;
  int? baseAttackMax;
  int? baseStr;
  int? baseAgi;
  int? baseInt;
  num? strGain;
  num? agiGain;
  num? intGain;
  int? attackRange;
  int? projectileSpeed;
  num? attackRate;
  int? moveSpeed;
  int? heroId;

  DotaHeroesModel({
    this.id,
    this.localizedName,
    this.primaryAttr,
    this.attackType,
    this.roles,
    this.img,
    this.icon,
    this.baseHealth,
    this.baseHealthRegen,
    this.baseMana,
    this.baseManaRegen,
    this.baseArmor,
    this.baseMr,
    this.baseAttackMin,
    this.baseAttackMax,
    this.baseStr,
    this.baseAgi,
    this.baseInt,
    this.strGain,
    this.agiGain,
    this.intGain,
    this.attackRange,
    this.projectileSpeed,
    this.attackRate,
    this.moveSpeed,
    this.heroId,
  });

  factory DotaHeroesModel.fromMap(Map<String, dynamic> map) {
    return DotaHeroesModel(
      id: map['id'],
      localizedName: map['localized_name'],
      primaryAttr: map['primary_attr'],
      attackType: map['attack_type'],
      roles: map['roles'],
      img: map['img'],
      icon: map['icon'],
      baseHealth: map['base_health'],
      baseHealthRegen: map['base_health_regen'],
      baseMana: map['base_mana'],
      baseManaRegen: map['base_mana_regen'],
      baseArmor: map['base_armor'],
      baseMr: map['base_mr'],
      baseAttackMin: map['base_attack_min'],
      baseAttackMax: map['base_attack_max'],
      baseStr: map['base_str'],
      baseAgi: map['base_agi'],
      baseInt: map['base_int'],
      strGain: map['str_gain'],
      agiGain: map['agi_gain'],
      intGain: map['int_gain'],
      attackRange: map['attack_range'],
      projectileSpeed: map['projectile_speed'],
      attackRate: map['attack_rate'],
      moveSpeed: map['move_speed'],
      heroId: map['hero_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'localizedName': localizedName,
      'primaryAttr': primaryAttr,
      'attackType': attackType,
      'roles': roles,
      'img': img,
      'icon': icon,
      'baseHealth': baseHealth,
      'baseHealthRegen': baseHealthRegen,
      'baseMana': baseMana,
      'baseManaRegen': baseManaRegen,
      'baseArmor': baseArmor,
      'baseMr': baseMr,
      'baseAttackMin': baseAttackMin,
      'baseAttackMax': baseAttackMax,
      'baseStr': baseStr,
      'baseAgi': baseAgi,
      'baseInt': baseInt,
      'strGain': strGain,
      'agiGain': agiGain,
      'intGain': intGain,
      'attackRange': attackRange,
      'projectileSpeed': projectileSpeed,
      'attackRate': attackRate,
      'moveSpeed': moveSpeed,
      'heroId': heroId,
    };
  }

  factory DotaHeroesModel.fromJson(dynamic json) {
    return DotaHeroesModel(
      id: json['id'],
      localizedName: json['localized_name'],
      primaryAttr: json['primary_attr'],
      attackType: json['attack_type'],
      roles: json['roles'],
      img: json['img'],
      icon: json['icon'],
      baseHealth: json['base_health'],
      baseHealthRegen: json['base_health_regen'],
      baseMana: json['base_mana'],
      baseManaRegen: json['base_mana_regen'],
      baseArmor: json['base_armor'],
      baseMr: json['base_mr'],
      baseAttackMin: json['base_attack_min'],
      baseAttackMax: json['base_attack_max'],
      baseStr: json['base_str'],
      baseAgi: json['base_agi'],
      baseInt: json['base_int'],
      strGain: json['str_gain'],
      agiGain: json['agi_gain'],
      intGain: json['int_gain'],
      attackRange: json['attack_range'],
      projectileSpeed: json['projectile_speed'],
      attackRate: json['attack_rate'],
      moveSpeed: json['move_speed'],
      heroId: json['hero_id'],
    );
  }
}
