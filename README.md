# workingldap

This project enables you to instantly configure an ldap server that persists its data and enforces unique uidNumbers.

To compile, run this:

  docker-compose build

To start the server/client pair, run this:

  docker-compose down && docker-compose up -d
 
To test whether it's working, login to the client as follows:

  docker exec -it ldapclient bash

Once in, run the following command s:

  $ cd
  $ bash test.sh.sh
  $ bash test.sh

In the output, you should see that the user 'yoda' was successfully added, while the user 'spock' could not be added.
