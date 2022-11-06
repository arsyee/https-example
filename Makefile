.RECIPEPREFIX = >
.PHONY = default clean

default: server/cert.crt

clean:
>    rm -f ca/CA* server/cert*

# https://priyalwalpita.medium.com/create-your-own-certificate-authority-47f49d0ba086

ca/CA.key: ca/passphrase
>    openssl genrsa `# generate RSA private key` \
            -des3 `# encrypt private key with DES3` \
            -passout file:ca/passphrase `# use password from file for encryption` \
            -out ca/CA.key `# output key to this file` \
            2048 `# size of the key in bits`

ca/CA.pem: ca/CA.key ca/config.req
>    openssl req `# process certificate request` \
            -new `# generate new request` \
            -x509 `# output self-signed cert instead of request` \
            -config ca/config.req \
            -nodes `# do not encrypt private key ???` \
            -key ca/CA.key `# read private key from this file` \
            -passin file:ca/passphrase `# password to decrypt private key` \
            -sha256 `# message digest` \
            -days 365 `# validity in days` \
            -out ca/CA.pem `# output into this file`

server/cert.key:
>    openssl genrsa `# generate RSA private key` \
            -out server/cert.key `# output key to this file` \
            2048 `# size of the key in bits`

server/cert.csr: server/cert.key server/config.req
>    openssl req -new `# process certificate request` \
            -new `# generate new request` \
            -config server/config.req \
            -key server/cert.key `# read private key from this file` \
            -out server/cert.csr `# output into this file`

server/cert.crt: server/cert.csr ca/CA.pem ca/CA.key ca/passphrase
>    openssl x509 \
             -req \
             -in server/cert.csr \
             -CA ca/CA.pem \
             -CAkey ca/CA.key \
             -passin file:ca/passphrase `# password to decrypt private key` \
             -CAcreateserial \
             -sha256 \
             -days 365 \
             -out server/cert.crt
