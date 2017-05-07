#!/bin/bash

# Arret de la base LDAP
/etc/init.d/slapd stop

# Reset de la base
rm -Rf /var/lib/ldap/*

# Import de la la bse initiale
chown openldap /var/lib/ldap/*

# Changement des droits
chown -Rf openldap: /var/lib/ldap/

# Redemarrage de l'annuaire
/etc/init.d/slapd start

