module Node.Crypto.Types
  ( Algorithm(..)
  , AuthAlgorithm(..)
  , Password(..)
  , Plaintext(..)
  , Ciphertext(..)
  , Key(..)
  , AuthTag(..)
  , InitializationVector(..)
  ) where

-- Notes:
-- iv is optional (null if no iv needed)
-- setAuthTag is optional: it is needed for authenticated encryption modes (GCM, CCM and OCB are currently supported)
-- key and iv should be utf-8 encoded or buffers
-- createCipher authTagLength needed for CCM or OCB, but is not added, yet

import Data.Show (class Show, show)
import Data.Newtype (class Newtype)
import Node.Buffer (Buffer)
import Data.Eq (class Eq)

data AuthAlgorithm
  = AES256GCM

data Algorithm
  = AES128
  | AES192
  | AES256
  | AES256CBC
  | WithAuth AuthAlgorithm

newtype Password
  = Password String

instance ntPassword :: Newtype Password String

newtype Key
  = Key String

instance ntKey :: Newtype Key String

newtype Plaintext
  = Plaintext String

instance ntPlaintext :: Newtype Plaintext String
derive newtype instance eqPlaintext :: Eq Plaintext

instance showPlaintext :: Show Plaintext where
  show (Plaintext p) = p

newtype Ciphertext
  = Ciphertext String

instance ntCiphertext :: Newtype Ciphertext String
derive newtype instance eqCiphertext :: Eq Ciphertext

instance showCiphertext :: Show Ciphertext where
  show (Ciphertext c) = c

newtype AuthTag
  = AuthTag Buffer

instance ntAuthTag :: Newtype AuthTag Buffer

newtype InitializationVector
  = InitializationVector String

instance ntInitializationVector :: Newtype InitializationVector String

instance showAlgorithm :: Show Algorithm where
  show AES128 = "aes128"
  show AES192 = "aes192"
  show AES256 = "aes256"
  show AES256CBC = "aes-256-cbc"
  show (WithAuth algo) = show algo
  
instance showAuthAlgorithm :: Show AuthAlgorithm where
  show AES256GCM = "aes-256-gcm"
  

{-- Further algorithms
AES-128-CBC
AES-128-CBC-HMAC-SHA1
AES-128-CFB
AES-128-CFB1
AES-128-CFB8
AES-128-CTR
AES-128-ECB
AES-128-OFB
AES-128-XTS
AES-192-CBC
AES-192-CFB
AES-192-CFB1
AES-192-CFB8
AES-192-CTR
AES-192-ECB
AES-192-OFB
AES-256-CBC
AES-256-CBC-HMAC-SHA1
AES-256-CFB
AES-256-CFB1
AES-256-CFB8
AES-256-CTR
AES-256-ECB
AES-256-OFB
AES-256-XTS
AES128 => AES-128-CBC
AES192 => AES-192-CBC
AES256 => AES-256-CBC
BF => BF-CBC
BF-CBC
BF-CFB
BF-ECB
BF-OFB
CAMELLIA-128-CBC
CAMELLIA-128-CFB
CAMELLIA-128-CFB1
CAMELLIA-128-CFB8
CAMELLIA-128-ECB
CAMELLIA-128-OFB
CAMELLIA-192-CBC
CAMELLIA-192-CFB
CAMELLIA-192-CFB1
CAMELLIA-192-CFB8
CAMELLIA-192-ECB
CAMELLIA-192-OFB
CAMELLIA-256-CBC
CAMELLIA-256-CFB
CAMELLIA-256-CFB1
CAMELLIA-256-CFB8
CAMELLIA-256-ECB
CAMELLIA-256-OFB
CAMELLIA128 => CAMELLIA-128-CBC
CAMELLIA192 => CAMELLIA-192-CBC
CAMELLIA256 => CAMELLIA-256-CBC
CAST => CAST5-CBC
CAST-cbc => CAST5-CBC
CAST5-CBC
CAST5-CFB
CAST5-ECB
CAST5-OFB
ChaCha
DES => DES-CBC
DES-CBC
DES-CFB
DES-CFB1
DES-CFB8
DES-ECB
DES-EDE
DES-EDE-CBC
DES-EDE-CFB
DES-EDE-OFB
DES-EDE3
DES-EDE3-CBC
DES-EDE3-CFB
DES-EDE3-CFB1
DES-EDE3-CFB8
DES-EDE3-OFB
DES-OFB
DES3 => DES-EDE3-CBC
DESX => DESX-CBC
DESX-CBC
gost89
RC2 => RC2-CBC
RC2-40-CBC
RC2-64-CBC
RC2-CBC
RC2-CFB
RC2-ECB
RC2-OFB
RC4
RC4-40
RC4-HMAC-MD5
AES-128-CBC
AES-128-CBC-HMAC-SHA1
AES-128-CFB
AES-128-CFB1
AES-128-CFB8
AES-128-CTR
AES-128-ECB
id-aes128-GCM
AES-128-OFB
AES-128-XTS
AES-192-CBC
AES-192-CFB
AES-192-CFB1
AES-192-CFB8
AES-192-CTR
AES-192-ECB
id-aes192-GCM
AES-192-OFB
AES-256-CBC
AES-256-CBC-HMAC-SHA1
AES-256-CFB
AES-256-CFB1
AES-256-CFB8
AES-256-CTR
AES-256-ECB
id-aes256-GCM
AES-256-OFB
AES-256-XTS
aes128 => AES-128-CBC
aes192 => AES-192-CBC
aes256 => AES-256-CBC
bf => BF-CBC
BF-CBC
BF-CFB
BF-ECB
BF-OFB
blowfish => BF-CBC
CAMELLIA-128-CBC
CAMELLIA-128-CFB
CAMELLIA-128-CFB1
CAMELLIA-128-CFB8
CAMELLIA-128-ECB
CAMELLIA-128-OFB
CAMELLIA-192-CBC
CAMELLIA-192-CFB
CAMELLIA-192-CFB1
CAMELLIA-192-CFB8
CAMELLIA-192-ECB
CAMELLIA-192-OFB
CAMELLIA-256-CBC
CAMELLIA-256-CFB
CAMELLIA-256-CFB1
CAMELLIA-256-CFB8
CAMELLIA-256-ECB
CAMELLIA-256-OFB
camellia128 => CAMELLIA-128-CBC
camellia192 => CAMELLIA-192-CBC
camellia256 => CAMELLIA-256-CBC
cast => CAST5-CBC
cast-cbc => CAST5-CBC
CAST5-CBC
CAST5-CFB
CAST5-ECB
CAST5-OFB
ChaCha
des => DES-CBC
DES-CBC
DES-CFB
DES-CFB1
DES-CFB8
DES-ECB
DES-EDE
DES-EDE-CBC
DES-EDE-CFB
DES-EDE-OFB
DES-EDE3
DES-EDE3-CBC
DES-EDE3-CFB
DES-EDE3-CFB1
DES-EDE3-CFB8
DES-EDE3-OFB
DES-OFB
des3 => DES-EDE3-CBC
desx => DESX-CBC
DESX-CBC
gost89
gost89-cnt
gost89-ecb
id-aes128-GCM
id-aes192-GCM
id-aes256-GCM
rc2 => RC2-CBC
RC2-40-CBC
RC2-64-CBC
RC2-CBC
RC2-CFB
RC2-ECB
RC2-OFB
RC4
RC4-40
RC4-HMAC-MD5
-}