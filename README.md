All I see are stars
===================

About
-----
The "hunter2" password manager is a simple script-oriented password 
manager.  You request that passwords be stored by a given identifier and 
then later retrieve them with that identifier.

Passwords are encrypted using your public RSA key and can be decrypted 
with your private RSA key.  Currently only keys stored on hardware 
security modules (such as smartcards, TPMs, etc) are supported.

Passwords may be shared among users of the same database and anyone who 
can decrypt the password may add additional users be able to access the 
password.

Passwords are stored in a simple SQLite3 DB.  AES-128 is used to encrypt 
the passwords and RSA is used to encrypt the AES key.

Demo
----
<script type="text/javascript" src="https://asciinema.org/a/39190.js" id="asciicast-39190" async></script>
