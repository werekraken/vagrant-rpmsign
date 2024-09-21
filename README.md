# vagrant-rpmsign

Automated rpm signing inside a vagrant managed machine. This project is intended for use in environments where it is impractical or undesirable to install a native `rpmsign` executable.

## Setup

* Securing the private key and passphrase is out-of-scope for this project and is, therefore, left to the user.
* The public key, private key, and passphrase must all be placed in files in the project root.
* The public key file must match the glob pattern `RPM-GPG-KEY-*-public.asc`.
```
gpg --export --armor 'Demo Signing Key' > RPM-GPG-KEY-Demo-public.asc
```
* The private key file must match the glob pattern `RPM-GPG-KEY-*-private.asc`.
```
gpg --export-secret-key --armor 'Demo Signing Key' > RPM-GPG-KEY-Demo-private.asc
```
* The private key passphrase file must match the glob pattern `RPM-GPG-KEY-*-passphrase`.
```
vi RPM-GPG-KEY-Demo-passphrase
```
* Create a symlink with the desired executable name (e.g. `rpmsign-demo` will sign rpms with `RPM-GPG-KEY-Demo-private.asc` for publishing to the "Demo" repo family).
```
sudo ln -s "`realpath runner.sh`" /usr/local/bin/rpmsign-demo
```

## Usage

The preferred usage is to use the symlink previously named as desired (see above).
```
cd /path/to/demo/rpms/
rpmsign-demo
```
Upon success the signed rpms will be placed in a subdirectory named `signed`. In this example, `/path/to/demo/rpms/signed/`.

Alternatively, you can execute `runner.sh` directly.
```
cd /path/to/rpms/
/path/to/vagrant-rpmsign/runner.sh
```
Upon success of this example, signed rpms will be placed in `/path/to/rpms/signed/`.
