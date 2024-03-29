# https-example

## How TLS works?

https://en.wikipedia.org/wiki/Transport_Layer_Security

### Parties

Certificate Authority (CA) is a trusted 3rd party, signing the keys of the Server.

Server generates a key-pair and asks the CA to sign it.

Client wants to talk to the Server.

### Client-Server interaction

- ClientHello
    - list of available ciphers and hashes
- ServerHello
    - selected cipher and hash
    - certificate
        - public key
        - domain
        - ...
        - signed by CA
- Client checks if certificate
    - using the CA's public key - if that is OK, CA really signed, so Server can be trusted
- Client starts communicating using the Server's public key
    - probably negotiate a symmetric key
    - ...

## Content

requirements.txt # python dependencies
Makefile # to generate the required keys/certificates

### CA - Certificate Authority

Stores files of the CA. Currently this is only the config.req, all the other files are generated by make.

### server - example HTTPS server using Flask

Also stores the certificate of server, generated by make.

### client

- client.sh # curl example
- client.py # Python example, to be developed
