import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class RSAUtils {
  static RSAPublicKey? publicKey;

  static RSAUtils? instance;

  //Singleton mode
  static RSAUtils? getInstance(String pubKey) {
    if (instance == null) {
      instance = RSAUtils(pubKey);
    }
    return instance;
  }

  RSAUtils(String pubKey) {
    publicKey = parse(pubKey) as RSAPublicKey?;
  }

  ///RSA public key encryption
  String encryptByPublicKey(String jsonString) {
    String result = "";
    try {
      result = encrypt(jsonString, publicKey!);
      var bytes = utf8.encode(result);
      result = base64.encode(bytes);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  String? encryptStr(Uint8List data) {
    try {
      var keyParameter = () => PublicKeyParameter<RSAPublicKey>(publicKey!);
      AsymmetricBlockCipher cipher = AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(true, keyParameter());
      int index = 0;
      int strlength = data.length;
      final keysize = publicKey!.modulus!.bitLength ~/ 8 - 11;
      final blocksize = publicKey!.modulus!.bitLength ~/ 8;
      final numBlocks =
          (strlength ~/ keysize) + ((strlength % keysize != 0) ? 1 : 0);
      Uint8List list = Uint8List(blocksize * numBlocks);
      int count = 0;
      while (index < strlength) {
        Uint8List listtmp;
        if (index + keysize > strlength) {
          listtmp = data.sublist(index, strlength);
          index = strlength;
        } else {
          listtmp = data.sublist(index, index + keysize);
          index += keysize;
        }
        Uint8List encryptResult = cipher.process(listtmp);
        for (int i = 0; i < blocksize; i++) {
          list[count * blocksize + i] = encryptResult[i];
        }
        count += 1;
      }
      Uint8List bytes = Uint8List.fromList(list);
      return base64Encode(bytes);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  RSAAsymmetricKey? parse(String key) {
    final rows = key.split('\n'); // LF-only, this could be a problem
    final header = rows.first;
    if (header == '-----BEGIN RSA PUBLIC KEY-----') {
      return _parsePublic(_parseSequence(rows));
    }

    if (header == '-----BEGIN PUBLIC KEY-----') {
      return _parsePublic(_pkcs8PublicSequence(_parseSequence(rows)));
    }

    if (header == '-----BEGIN RSA PRIVATE KEY-----') {
      return _parsePrivate(_parseSequence(rows));
    }

    if (header == '-----BEGIN PRIVATE KEY-----') {
      return _parsePrivate(_pkcs8PrivateSequence(_parseSequence(rows)));
    }
    // NOTE: Should we throw an exception?
    return null;
  }

  RSAAsymmetricKey _parsePublic(ASN1Sequence sequence) {
    final modulus = (sequence.elements[0] as ASN1Integer).valueAsBigInteger;
    final exponent = (sequence.elements[1] as ASN1Integer).valueAsBigInteger;

    return RSAPublicKey(modulus!, exponent!);
  }

  RSAAsymmetricKey _parsePrivate(ASN1Sequence sequence) {
    final modulus = (sequence.elements[1] as ASN1Integer).valueAsBigInteger;
    final exponent = (sequence.elements[3] as ASN1Integer).valueAsBigInteger;
    final p = (sequence.elements[4] as ASN1Integer).valueAsBigInteger;
    final q = (sequence.elements[5] as ASN1Integer).valueAsBigInteger;

    return RSAPrivateKey(modulus!, exponent!, p, q);
  }

  ASN1Sequence _parseSequence(List<String> rows) {
    final keyText = rows
        .skipWhile((row) => row.startsWith('-----BEGIN'))
        .takeWhile((row) => !row.startsWith('-----END'))
        .map((row) => row.trim())
        .join('');

    final keyBytes = Uint8List.fromList(base64.decode(keyText));
    final asn1Parser = ASN1Parser(keyBytes);

    return asn1Parser.nextObject() as ASN1Sequence;
  }

  ASN1Sequence _pkcs8PublicSequence(ASN1Sequence sequence) {
    final ASN1Object bitString = sequence.elements[1];
    final bytes = bitString.valueBytes().sublist(1);
    final parser = ASN1Parser(Uint8List.fromList(bytes));

    return parser.nextObject() as ASN1Sequence;
  }

  ASN1Sequence _pkcs8PrivateSequence(ASN1Sequence sequence) {
    final ASN1Object bitString = sequence.elements[2];
    final bytes = bitString.valueBytes();
    final parser = ASN1Parser(bytes);

    return parser.nextObject() as ASN1Sequence;
  }
}
