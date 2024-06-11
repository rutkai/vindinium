*Four legendary heroes were fighting for the land of Vindinium*

*Making their way in the dangerous woods*

*Slashing goblins and stealing gold mines*

*And looking for a tavern where to drink their gold*

### Home

https://vindinium.idealib.net

### Installation

Feel free to install a local instance for your private tournaments.
You need [sbt](https://www.scala-sbt.org/), a MongoDB instance running, and a Unix machine (only Linux has been tested, tho).

```sh
git clone git://github.com/ornicar/vindinium
cd vindinium
cd client
./build.sh
cd ..
sbt compile
sbt run
```

Vindinium is now running on `http://localhost:9000`.

#### Optional reverse proxy

Here's an example of nginx configuration:

```
server {
 listen 80;
 server_name my-domain.org;

  location / {
    proxy_http_version 1.1;
    proxy_read_timeout 24h;
    proxy_set_header Host $host;
    proxy_pass  http://127.0.0.1:9000/;
  }
}
```

### Developing on the Client Side stack

make a copy of `conf/application.conf.dist` as `conf/application.conf`.
while the Server runs with a `sbt run`, you can go in another terminal in the `client/` folder and:

- Install once the dependencies with `npm install` (This requires nodejs to be installed)
- Be sure to have `grunt` installed with `npm install -g grunt-cli`
- Use `grunt` to compile client sources and watch for client source changes.

### Credits

Kudos to:

- [vjousse](https://github.com/vjousse) for the UI and testing
- [veloce](https://github.com/veloce) for the JavaScript and testing
- [gre](https://github.com/gre) for the shiny new JS playground

### Notes from the future!

The simplest way to run now on most machines (linux/amd64) is to simply run:

```sh
# Start the containers!
docker-compose up -d

# Check the logs!
docker-compose logs -f
```

If you want to run on an ARMv8 platform (tested on Raspberry Pi 4) you can run the ARM64 specific containers:

```sh
docker-compose -f docker-compose-arm64.yaml -- up -d
```
