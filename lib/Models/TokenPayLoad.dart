 import 'package:review_app/Models/UserInfo.dart';

class TokenPayLoad
{
   String jti,iss,aud,role;
   int exp;
 UserInfo userInfo;

   TokenPayLoad({this.jti, this.iss, this.aud, this.exp, this.userInfo,this.role});

  factory TokenPayLoad.fromJson(Map<String, dynamic> json) => TokenPayLoad(
     exp:json["exp"],
     iss:json['iss'],
     aud:json['aud'],
     jti:json['jti'],
      role: json["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"],
    userInfo: UserInfo.fromJson(json['UserInfo'])
   );

   Map<String, dynamic> toJson() => {
     "exp":exp,
     "iss":iss,
      "aud":aud,
      "jti":jti,
     "userInfo":userInfo.toJson()
   };
}
