module Test.Main where

import Prelude
import Effect (Effect)
import Node.Encoding (Encoding(UTF8, Hex, Base64))
import Node.Crypto as Crypto
import Node.Crypto.Cipher as Cipher
import Node.Crypto.Decipher as Decipher
import Node.Crypto.Hash as Hash
import Node.Crypto.Hmac as Hmac
import Node.Crypto.Types as Types
import Test.Assert (assert)

main :: Effect Unit
main = do
  hexHash <- Hash.hex Hash.SHA512 "sample_password"
  hexHmac <- Hmac.hex Hash.SHA512 secret "sample_password"
  hexCipher <- Cipher.hex Types.AES256 password identifier
  fromHexDecipher <- Decipher.fromHex Types.AES256 password hexCipher
  base64Hash <- Hash.base64 Hash.SHA512 "sample_password"
  base64Hmac <- Hmac.base64 Hash.SHA512 secret "sample_password"
  base64Cipher <- Cipher.base64 Types.AES256 password identifier
  fromBase64Decipher <- Decipher.fromBase64 Types.AES256 password base64Cipher
  base64CipherIv <- Cipher.base64Iv Types.AES256GCM key iv sample_plaintext
  fromBase64DecipherIv <- Decipher.fromBase64Iv Types.AES256GCM key iv (base64CipherIv.authTag) (base64CipherIv.ciphertext)
  assert $ hexHash == "fd369c76561c41e90eaacef9e95dde1b92a402980b75d739da368ad427e2a5a01bc79e5a6fb46df001b8e21c94e702bfb47574271e4098150854e112bb9c9d1d"
  assert $ hexHmac == "64ca657263492b718984ab0a4a5a2a43288c35d9e15c6797f2597ce8e8440e862c5495cf852f4044e6caa9fe58bf0972153fcb827a5581d06e72b404126dbf05"
  assert $ hexCipher == "fa27b1b589a3c39576c9cecfe5071682815da543fbce75c4823a6be70f0e1777"
  assert $ fromHexDecipher == identifier
  assert $ base64Hash == "/TacdlYcQekOqs756V3eG5KkApgLddc52jaK1CfipaAbx55ab7Rt8AG44hyU5wK/tHV0Jx5AmBUIVOESu5ydHQ=="
  assert $ base64Hmac == "ZMplcmNJK3GJhKsKSloqQyiMNdnhXGeX8ll86OhEDoYsVJXPhS9ARObKqf5YvwlyFT/LgnpVgdBucrQEEm2/BQ=="
  assert $ base64Cipher == "+iextYmjw5V2yc7P5QcWgoFdpUP7znXEgjpr5w8OF3c="
  assert $ fromBase64Decipher == identifier
  assert $ (show base64CipherIv.ciphertext) == "JdPl26+0QxWYxPyK5tT5+w=="
  assert $ (show fromBase64DecipherIv) == (show sample_plaintext)
  assert =<< Crypto.timingSafeEqualString "127e6fbfe24a750e72930c" "127e6fbfe24a750e72930c"

identifier :: String
identifier = "sample_identifier"

sample_plaintext :: Types.Plaintext
sample_plaintext = Types.Plaintext "sample_plaintext"

iv :: Types.InitializationVector
iv = (Types.InitializationVector "1234567890123456")

password :: Types.Password
password = Types.Password "sample_password"

key :: Types.Key
key = Types.Key "12345678901234567890123456789012"

secret :: Hmac.Secret
secret = Hmac.Secret "sample_secret"

-- manualEncryption :: String
-- manualEncryption = do
--   buf <- fromString identifier UTF8
--   cip <- Cipher.createCipherIv Types.AES256GCM key iv
--   rbuf1 <- Cipher.update cip buf
--   rbuf2 <- Cipher.final cip
--   rbuf <- concat [ rbuf1, rbuf2 ]
--   aTag <- Cipher.getAuthTag cip
--   encRes <- toString Base64 rbuf
--   encRes
-- manualDecryption :: String
-- manualDecryption encRes tag = do
--   buf <- fromString encRes Base64
--   dec <- Decipher.createDecipherIv Types.AES256GCM key iv
--   _ <- Decipher.setAuthTag dec tag
--   rbuf1 <- Decipher.update dec buf
--   rbuf2 <- Decipher.final dec
--   rbuf <- concat [ rbuf1, rbuf2 ]
--   decRes <- toString UTF8 rbuf
--   dec64 <- toString Base64 rbuf
--   dec64
