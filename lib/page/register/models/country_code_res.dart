import 'dart:convert';

import 'package:get/get.dart';

class CountryCodeRes {
  List<CountryCode>? list;

  CountryCodeRes({this.list});

  CountryCodeRes.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CountryCode>[];
      json['list'].forEach((v) {
        list!.add(new CountryCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static String jsonString = "{\"list\":[{\"name\":\"Afghanistan\",\"id\":\"93\"},{\"name\":\"Albania\",\"id\":\"355\"},{\"name\":\"Algeria\",\"id\":\"213\"},{\"name\":\"AmericanSamoa\",\"id\":\"1\"},{\"name\":\"Andorra\",\"id\":\"376\"},{\"name\":\"Angola\",\"id\":\"244\"},{\"name\":\"Anguilla\",\"id\":\"1\"},{\"name\":\"AntiguaandBarbuda\",\"id\":\"1\"},{\"name\":\"Argentina\",\"id\":\"54\"},{\"name\":\"Armenia\",\"id\":\"374\"},{\"name\":\"Aruba\",\"id\":\"297\"},{\"name\":\"Ascension\",\"id\":\"247\"},{\"name\":\"Australia\",\"id\":\"61\"},{\"name\":\"Austria\",\"id\":\"43\"},{\"name\":\"Azerbaijan\",\"id\":\"994\"},{\"name\":\"Bahamas\",\"id\":\"1\"},{\"name\":\"Bahrain\",\"id\":\"973\"},{\"name\":\"Bangladesh\",\"id\":\"880\"},{\"name\":\"Barbados\",\"id\":\"1\"},{\"name\":\"Belarus\",\"id\":\"375\"},{\"name\":\"Belgium\",\"id\":\"32\"},{\"name\":\"Belize\",\"id\":\"501\"},{\"name\":\"Benin\",\"id\":\"229\"},{\"name\":\"Bermuda\",\"id\":\"1\"},{\"name\":\"Bhutan\",\"id\":\"975\"},{\"name\":\"Bolivia\",\"id\":\"591\"},{\"name\":\"BosniaandHerzegovina\",\"id\":\"387\"},{\"name\":\"Botswana\",\"id\":\"267\"},{\"name\":\"Brazil\",\"id\":\"55\"},{\"name\":\"BritishVirginIslands\",\"id\":\"1\"},{\"name\":\"Brunei\",\"id\":\"673\"},{\"name\":\"Bulgaria\",\"id\":\"359\"},{\"name\":\"BurkinaFaso\",\"id\":\"226\"},{\"name\":\"Burundi\",\"id\":\"257\"},{\"name\":\"Cambodia\",\"id\":\"855\"},{\"name\":\"Cameroon\",\"id\":\"237\"},{\"name\":\"Canada\",\"id\":\"1\"},{\"name\":\"CapeVerde\",\"id\":\"238\"},{\"name\":\"CaymanIslands\",\"id\":\"1\"},{\"name\":\"CentralAfricanRepublic\",\"id\":\"236\"},{\"name\":\"Chad\",\"id\":\"235\"},{\"name\":\"Chile\",\"id\":\"56\"},{\"name\":\"China\",\"id\":\"86\"},{\"name\":\"Colombia\",\"id\":\"57\"},{\"name\":\"Comoros\",\"id\":\"269\"},{\"name\":\"Congo\",\"id\":\"242\"},{\"name\":\"CookIslands\",\"id\":\"682\"},{\"name\":\"CostaRica\",\"id\":\"506\"},{\"name\":\"Croatia\",\"id\":\"385\"},{\"name\":\"Cuba\",\"id\":\"53\"},{\"name\":\"Curacao\",\"id\":\"599\"},{\"name\":\"Cyprus\",\"id\":\"357\"},{\"name\":\"CzechRepublic\",\"id\":\"420\"},{\"name\":\"DemocraticRepublicofCongo\",\"id\":\"243\"},{\"name\":\"Denmark\",\"id\":\"45\"},{\"name\":\"DiegoGarcia\",\"id\":\"246\"},{\"name\":\"Djibouti\",\"id\":\"253\"},{\"name\":\"Dominica\",\"id\":\"1\"},{\"name\":\"DominicanRepublic\",\"id\":\"1\"},{\"name\":\"EastTimor\",\"id\":\"670\"},{\"name\":\"Ecuador\",\"id\":\"593\"},{\"name\":\"Egypt\",\"id\":\"20\"},{\"name\":\"ElSalvador\",\"id\":\"503\"},{\"name\":\"EquatorialGuinea\",\"id\":\"240\"},{\"name\":\"Eritrea\",\"id\":\"291\"},{\"name\":\"Estonia\",\"id\":\"372\"},{\"name\":\"Ethiopia\",\"id\":\"251\"},{\"name\":\"Falkland(Malvinas)Islands\",\"id\":\"500\"},{\"name\":\"FaroeIslands\",\"id\":\"298\"},{\"name\":\"Fiji\",\"id\":\"679\"},{\"name\":\"Finland\",\"id\":\"358\"},{\"name\":\"France\",\"id\":\"33\"},{\"name\":\"FrenchGuiana\",\"id\":\"594\"},{\"name\":\"FrenchPolynesia\",\"id\":\"689\"},{\"name\":\"Gabon\",\"id\":\"241\"},{\"name\":\"Gambia\",\"id\":\"220\"},{\"name\":\"Georgia\",\"id\":\"995\"},{\"name\":\"Germany\",\"id\":\"49\"},{\"name\":\"Ghana\",\"id\":\"233\"},{\"name\":\"Gibraltar\",\"id\":\"350\"},{\"name\":\"Greece\",\"id\":\"30\"},{\"name\":\"Greenland\",\"id\":\"299\"},{\"name\":\"Grenada\",\"id\":\"1\"},{\"name\":\"Guadeloupe\",\"id\":\"590\"},{\"name\":\"Guam\",\"id\":\"1\"},{\"name\":\"Guatemala\",\"id\":\"502\"},{\"name\":\"Guinea\",\"id\":\"224\"},{\"name\":\"Guinea-Bissau\",\"id\":\"245\"},{\"name\":\"Guyana\",\"id\":\"592\"},{\"name\":\"Haiti\",\"id\":\"509\"},{\"name\":\"Honduras\",\"id\":\"504\"},{\"name\":\"HongKong\",\"id\":\"852\"},{\"name\":\"Hungary\",\"id\":\"36\"},{\"name\":\"Iceland\",\"id\":\"354\"},{\"name\":\"India\",\"id\":\"91\"},{\"name\":\"Indonesia\",\"id\":\"62\"},{\"name\":\"InmarsatSatellite\",\"id\":\"870\"},{\"name\":\"Iran\",\"id\":\"98\"},{\"name\":\"Iraq\",\"id\":\"964\"},{\"name\":\"Ireland\",\"id\":\"353\"},{\"name\":\"IridiumSatellite\",\"id\":\"8816/8817\"},{\"name\":\"Israel\",\"id\":\"972\"},{\"name\":\"Italy\",\"id\":\"39\"},{\"name\":\"IvoryCoast\",\"id\":\"225\"},{\"name\":\"Jamaica\",\"id\":\"1\"},{\"name\":\"Japan\",\"id\":\"81\"},{\"name\":\"Jordan\",\"id\":\"962\"},{\"name\":\"Kazakhstan\",\"id\":\"7\"},{\"name\":\"Kenya\",\"id\":\"254\"},{\"name\":\"Kiribati\",\"id\":\"686\"},{\"name\":\"Kuwait\",\"id\":\"965\"},{\"name\":\"Kyrgyzstan\",\"id\":\"996\"},{\"name\":\"Laos\",\"id\":\"856\"},{\"name\":\"Latvia\",\"id\":\"371\"},{\"name\":\"Lebanon\",\"id\":\"961\"},{\"name\":\"Lesotho\",\"id\":\"266\"},{\"name\":\"Liberia\",\"id\":\"231\"},{\"name\":\"Libya\",\"id\":\"218\"},{\"name\":\"Liechtenstein\",\"id\":\"423\"},{\"name\":\"Lithuania\",\"id\":\"370\"},{\"name\":\"Luxembourg\",\"id\":\"352\"},{\"name\":\"Macau\",\"id\":\"853\"},{\"name\":\"Macedonia\",\"id\":\"389\"},{\"name\":\"Madagascar\",\"id\":\"261\"},{\"name\":\"Malawi\",\"id\":\"265\"},{\"name\":\"Malaysia\",\"id\":\"60\"},{\"name\":\"Maldives\",\"id\":\"960\"},{\"name\":\"Mali\",\"id\":\"223\"},{\"name\":\"Malta\",\"id\":\"356\"},{\"name\":\"MarshallIslands\",\"id\":\"692\"},{\"name\":\"Martinique\",\"id\":\"596\"},{\"name\":\"Mauritania\",\"id\":\"222\"},{\"name\":\"Mauritius\",\"id\":\"230\"},{\"name\":\"Mayotte\",\"id\":\"262\"},{\"name\":\"Mexico\",\"id\":\"52\"},{\"name\":\"Micronesia\",\"id\":\"691\"},{\"name\":\"Moldova\",\"id\":\"373\"},{\"name\":\"Monaco\",\"id\":\"377\"},{\"name\":\"Mongolia\",\"id\":\"976\"},{\"name\":\"Montenegro\",\"id\":\"382\"},{\"name\":\"Montserrat\",\"id\":\"1\"},{\"name\":\"Morocco\",\"id\":\"212\"},{\"name\":\"Mozambique\",\"id\":\"258\"},{\"name\":\"Myanmar\",\"id\":\"95\"},{\"name\":\"Namibia\",\"id\":\"264\"},{\"name\":\"Nauru\",\"id\":\"674\"},{\"name\":\"Nepal\",\"id\":\"977\"},{\"name\":\"Netherlands\",\"id\":\"31\"},{\"name\":\"NetherlandsAntilles\",\"id\":\"599\"},{\"name\":\"NewCaledonia\",\"id\":\"687\"},{\"name\":\"NewZealand\",\"id\":\"64\"},{\"name\":\"Nicaragua\",\"id\":\"505\"},{\"name\":\"Niger\",\"id\":\"227\"},{\"name\":\"Nigeria\",\"id\":\"234\"},{\"name\":\"Niue\",\"id\":\"683\"},{\"name\":\"NorfolkIsland\",\"id\":\"6723\"},{\"name\":\"NorthKorea\",\"id\":\"850\"},{\"name\":\"NorthernMarianas\",\"id\":\"1\"},{\"name\":\"Norway\",\"id\":\"47\"},{\"name\":\"Oman\",\"id\":\"968\"},{\"name\":\"Pakistan\",\"id\":\"92\"},{\"name\":\"Palau\",\"id\":\"680\"},{\"name\":\"Panama\",\"id\":\"507\"},{\"name\":\"PapuaNewGuinea\",\"id\":\"675\"},{\"name\":\"Paraguay\",\"id\":\"595\"},{\"name\":\"Peru\",\"id\":\"51\"},{\"name\":\"Philippines\",\"id\":\"63\"},{\"name\":\"Poland\",\"id\":\"48\"},{\"name\":\"Portugal\",\"id\":\"351\"},{\"name\":\"PuertoRico\",\"id\":\"1\"},{\"name\":\"Qatar\",\"id\":\"974\"},{\"name\":\"Reunion\",\"id\":\"262\"},{\"name\":\"Romania\",\"id\":\"40\"},{\"name\":\"RussianFederation\",\"id\":\"7\"},{\"name\":\"Rwanda\",\"id\":\"250\"},{\"name\":\"SaintHelena\",\"id\":\"290\"},{\"name\":\"SaintKittsandNevis\",\"id\":\"1\"},{\"name\":\"SaintLucia\",\"id\":\"1\"},{\"name\":\"SaintPierreandMiquelon\",\"id\":\"508\"},{\"name\":\"SaintVincentandtheGrenadines\",\"id\":\"1\"},{\"name\":\"Samoa\",\"id\":\"685\"},{\"name\":\"SanMarino\",\"id\":\"378\"},{\"name\":\"SaoTomeandPrincipe\",\"id\":\"239\"},{\"name\":\"SaudiArabia\",\"id\":\"966\"},{\"name\":\"Senegal\",\"id\":\"221\"},{\"name\":\"Serbia\",\"id\":\"381\"},{\"name\":\"Seychelles\",\"id\":\"248\"},{\"name\":\"SierraLeone\",\"id\":\"232\"},{\"name\":\"Singapore\",\"id\":\"65\"},{\"name\":\"SintMaarten\",\"id\":\"1\"},{\"name\":\"Slovakia\",\"id\":\"421\"},{\"name\":\"Slovenia\",\"id\":\"386\"},{\"name\":\"SolomonIslands\",\"id\":\"677\"},{\"name\":\"Somalia\",\"id\":\"252\"},{\"name\":\"SouthAfrica\",\"id\":\"27\"},{\"name\":\"SouthKorea\",\"id\":\"82\"},{\"name\":\"SouthSudan\",\"id\":\"211\"},{\"name\":\"Spain\",\"id\":\"34\"},{\"name\":\"SriLanka\",\"id\":\"94\"},{\"name\":\"Sudan\",\"id\":\"249\"},{\"name\":\"Suriname\",\"id\":\"597\"},{\"name\":\"Swaziland\",\"id\":\"268\"},{\"name\":\"Sweden\",\"id\":\"46\"},{\"name\":\"Switzerland\",\"id\":\"41\"},{\"name\":\"Syria\",\"id\":\"963\"},{\"name\":\"Taiwan\",\"id\":\"886\"},{\"name\":\"Tajikistan\",\"id\":\"992\"},{\"name\":\"Tanzania\",\"id\":\"255\"},{\"name\":\"Thailand\",\"id\":\"66\"},{\"name\":\"ThurayaSatellite\",\"id\":\"88216\"},{\"name\":\"Togo\",\"id\":\"228\"},{\"name\":\"Tokelau\",\"id\":\"690\"},{\"name\":\"Tonga\",\"id\":\"676\"},{\"name\":\"TrinidadandTobago\",\"id\":\"1\"},{\"name\":\"Tunisia\",\"id\":\"216\"},{\"name\":\"Turkey\",\"id\":\"90\"},{\"name\":\"Turkmenistan\",\"id\":\"993\"},{\"name\":\"TurksandCaicosIslands\",\"id\":\"1\"},{\"name\":\"Tuvalu\",\"id\":\"688\"},{\"name\":\"Uganda\",\"id\":\"256\"},{\"name\":\"Ukraine\",\"id\":\"380\"},{\"name\":\"UnitedArabEmirates\",\"id\":\"971\"},{\"name\":\"UnitedKingdom\",\"id\":\"44\"},{\"name\":\"UnitedStatesofAmerica\",\"id\":\"1\"},{\"name\":\"U.S.VirginIslands\",\"id\":\"1\"},{\"name\":\"Uruguay\",\"id\":\"598\"},{\"name\":\"Uzbekistan\",\"id\":\"998\"},{\"name\":\"Vanuatu\",\"id\":\"678\"},{\"name\":\"VaticanCity\",\"id\":\"379,39\"},{\"name\":\"Venezuela\",\"id\":\"58\"},{\"name\":\"Vietnam\",\"id\":\"84\"},{\"name\":\"WallisandFutuna\",\"id\":\"681\"},{\"name\":\"Yemen\",\"id\":\"967\"},{\"name\":\"Zambia\",\"id\":\"260\"},{\"name\":\"Zimbabwe\",\"id\":\"263\"}]}";

  static List<CountryCode> listCountryCode(){

    var data = jsonDecode(jsonString);

    var res = CountryCodeRes.fromJson(data);

    return res.list ?? [];
  }
}

class CountryCode {
  String? name;
  String? id;
  RxBool isChecked = false.obs;

  CountryCode({this.name, this.id});

  CountryCode.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}