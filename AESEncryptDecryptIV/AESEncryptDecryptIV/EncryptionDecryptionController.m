//
//  EncryptionDecryptionController.m
//  AESEncryptDecryptIV
//
//  Created by Abbie on 02/11/20.
//

#import "EncryptionDecryptionController.h"
#import "Crypt.h"
#import "SecurityUtils.h"
#import "FBEncryptorAES.h"

@interface EncryptionDecryptionController ()
{
   // CryptLib *cryptingInstance;
    NSData *encryptedText;
    NSString *encrypted;
}

@end

@implementation EncryptionDecryptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)encryptAction:(id)sender {
//    NSString *dataHexString = @"EA010B23CDA9B16F0001020304050607";
//    NSString *keyHexString = @"000102030405060708090A0B0C0D0E0F";
//    NSString *ivHexString = @"00102030405060708090A0B0C0D0E0F0";
//
//    NSLog(@"dataHexString: %@", dataHexString);
//    NSLog(@"keyHexString:  %@", keyHexString);
//    NSLog(@"ivHexString:   %@", ivHexString);
//
//    NSData *data = [Crypt dataFromHexString:dataHexString];
//    NSData *key  = [Crypt dataFromHexString:keyHexString];
//    NSData *iv   = [Crypt dataFromHexString:ivHexString];
//
//    NSLog(@"data: %@", data);
//    NSLog(@"key:  %@", key);
//    NSLog(@"iv:   %@", iv);
//
//    NSError *error;
//    NSData *encryptedData = [Crypt
//                             aes128Data:data
//                             operation:kCCEncrypt
//                             key:key
//                             options:0
//                             iv:iv
//                             error:&error];
//
//    NSLog(@"encryptedData %@", encryptedData);
    
    NSString *myScretString = @"My secret string";
    NSString *mySecretKey = @"9336365521W5F092BB5909E8E033BC69";
    
    NSData* iv = [FBEncryptorAES generateIv];
    NSString* hexString = [FBEncryptorAES hexStringForData:iv];
    NSString *iv_string = [iv base64EncodedStringWithOptions:0];
    NSLog(@"IV string: %@",iv_string);
    NSLog(@"HexIVV%@", hexString);
    NSLog(@"LengthDATAIV%lu", (unsigned long)[iv length]);
    NSData* encryptedData = [FBEncryptorAES encryptData:[myScretString dataUsingEncoding:NSUTF8StringEncoding]
                                                    key:[mySecretKey dataUsingEncoding:NSUTF8StringEncoding]
                                                     iv:iv];
    NSLog(@"encryptedWithDynamicIV: %@", [encryptedData base64EncodedStringWithOptions:0]);
    
    NSData* decryptedData = [FBEncryptorAES decryptData:encryptedData
                                                    key:[mySecretKey dataUsingEncoding:NSUTF8StringEncoding]
                                                     iv:iv];
    NSLog(@"decryptedWithDynamicIV: %@", [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding]);
    
    
    encrypted = [FBEncryptorAES encryptBase64String:@"My secret string"
                                                     keyString:@"9336365521W5F092BB5909E8E033BC69"
                                                 separateLines:NO];
   // NSLog(@"encrypted: %@", encrypted);
}
- (IBAction)decryptAction:(id)sender {
    NSString* msg = [FBEncryptorAES decryptBase64String:encrypted                                               keyString:@"9336365521W5F092BB5909E8E033BC69"];
    
    if (msg) {
      //  NSLog(@"decrypted: %@", msg);
    } else {
       // NSLog(@"failed to decrypt");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
