enum LanguageType{
  ENGLISH,PERSIAN
}
const String PERSIAN ="pr";
const String ENGLISH = "en";
extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){

      case LanguageType.ENGLISH:
     return ENGLISH;
      case LanguageType.PERSIAN:
       return PERSIAN;
    }
  }
}