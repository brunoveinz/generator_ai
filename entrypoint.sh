#!/bin/bash

# If running the rails server then create or migrate existing database
if [ "${*}" == "./bin/rails server" ]; then
  ./bin/rails db:create
  ./bin/rails db:prepare

  # Añade la opción -b 0.0.0.0 al comando rails server
  exec "${@}" -b 0.0.0.0
else
  # Para otros comandos, simplemente ejecuta el comando proporcionado
  exec "${@}"
fi