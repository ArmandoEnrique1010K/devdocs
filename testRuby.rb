require 'ffi'

module LibTest
  extend FFI::Library
  ffi_lib 'libcurl'  # Esto debería funcionar si el dll fue renombrado correctamente y está en el PATH
end

# Archivo para verificar si se encuentra el archivo libcurl.ddl en la carpeta donde se ha instalado Ruby, ese archivo deberia estar en "C:\Ruby34-x64\bin"
