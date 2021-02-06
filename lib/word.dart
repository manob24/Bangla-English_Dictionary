class Word {
  final String bn;
  final String en;
  final List pron;
  final List bn_syns;
  final List en_syns;
  final List sents;

  Word(this.pron,this.bn,this.en,this.bn_syns,this.en_syns,this.sents);

  factory Word.fromJson(Map<String, dynamic> json){
    return new Word(json['pron'], json['bn'], json['en'], json['bn_syns'], json['en_syns'], json['sents']);
  }

}
