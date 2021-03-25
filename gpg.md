# GPG

Allows you to encrypt and sign your data and communication.

- [Introduction](#introduction)
- [Create a key pair](#create-a-key-pair)
- [Export your public key](#export-your-public-key)
- [Import a public key](#import-a-public-key)
- [Encrypt and decrypt](#encrypt-and-decrypt)


## Introduction

GPG works in much the same way an SSH key or an SSL cert works, you have a public key which encrypts things and a matching private key which decrypts those things.
It’s safe to give out your public key but not your private key.

Here is the arch guide: https://wiki.archlinux.org/index.php/GnuPG. 
What you need is below.

## Create a key pair

```
gpg --full-gen-key

# the RSA (sign only) and a RSA (encrypt only) key.
# a keysize of the default value (2048).
# an expiration date - 1 year is good enough. Expiration can be extended without having to re-issue a new key.
# name and email address (seen by anybody who imports your key).
# You can add multiple identities to the same key later
# a secure passphrase.

# If you lose your secret key or it is compromised, you will want to revoke your
# key by uploading the revocation certificate to a public keyserver - assumes you uploaded your public key to a keyserver
# print out then store securely.

gpg --gen-revoke --armor --output=RevocationCertificate.asc <user-id>

# list public and secret keys
gpg --list-keys
gpg --list-secret-keys

# edit keys
gpg --edit-key <user-id>
```

## Export your public key

So that others can encrypt messages for you (stored in public.key file). User id is email.

```
gpg --output public.key --armor --export user-id
```

## Import a public key

In order to encrypt messages to others, as well as verify their signatures, you need their public key (below assumed to be stored in a file with the filename public.key). Verify the authenticity of the retrieved public key.

```
gpg --import public.key
```

## Encrypt and decrypt

After importing a public key. For decrypt, `gpg` will prompt you for your passphrase and then decrypt and write the data from doc.gpg to doc.

```
gpg --recipient user-id --encrypt doc
gpg --output doc --decrypt doc.gpg
```

note that to export your secret key for backup you can do `gpg2 --export-secret-keys > secret.gpg` but never put this anywhere unsafe as once it is in someone elses hands you are compromised.




