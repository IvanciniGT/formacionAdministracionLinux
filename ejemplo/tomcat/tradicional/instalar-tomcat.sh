#!/bin/bash

# En este archivo quiero poder usar las funciones que tengo definidas en el fichero utilidades.sh

#source "./utilidades.sh"    # Carga el contenido del fichero utilidades.sh
                            # A partir de aquí puedo usar las funciones definidas en utilidades.sh
                            # Es lo que en otros lenguajes de programación sería un "import" o un "include"
# Eso de arriba no funciona bien... Nunca lo hacemos así. 
# Solo funcionaría si ejecuto el script desde la misma carpeta donde está el script utilidades.sh
# Lo correcto es usar una ruta relativa a la ubicación de este script: instalar-tomcat.sh
source $( dirname "${BASH_SOURCE[0]}" )/utilidades.sh
# BASH_SOURCE[0] = ruta del script que se está ejecutando en este momento (instalar-tomcat.sh)

clear
mostrar_mensaje_informativo "Bienvenido al instalador de Tomcat"
echo

asegurar_usuario_root

# Preparar información a usar en la instalación
source $( dirname "${BASH_SOURCE[0]}" )/instalacion-tomcat.conf

echo "Buscando datos necesarios para la instalación..."

echo "Identificando al usuario de tomcat."
if [[ -z "$TOMCAT_USER" ]]; then
    mostrar_mensaje_advertencia "No se ha definido el usuario de Tomcat en el fichero de configuración."
    pedir_dato "Introduce el usuario bajo el cual se ejecutará Tomcat" \
                TOMCAT_USER \
               '^[a-z]{5,15}$' \
               "Usuario no válido: Debe tener entre 5 y 15 caracteres, solo minúsculas." \
               3 \
               "minúsculas" \
               "tomcat"
    if (( $? != 0 )); then
        mostrar_mensaje_error "No se ha podido obtener un usuario válido. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "Usuario identificado: $TOMCAT_USER"
fi

echo "Identificando al grupo de tomcat."
if [[ -z "$TOMCAT_GROUP" ]]; then
    mostrar_mensaje_advertencia "No se ha definido el grupo de Tomcat en el fichero de configuración."
    pedir_dato "Introduce el grupo bajo el cual se ejecutará Tomcat" \
                TOMCAT_GROUP \
               '^[a-z]{5,15}$' \
               "Grupo no válido: Debe tener entre 5 y 15 caracteres, solo minúsculas." \
               3 \
               "minúsculas" \
               "tomcat"
    if (( $? != 0 )); then
        mostrar_mensaje_error "No se ha podido obtener un grupo válido. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "Grupo identificado: $TOMCAT_GROUP"
fi

echo "Identificando la versión de Java."
if [[ -z "$JAVA_VERSION" ]]; then
    mostrar_mensaje_advertencia "No se ha definido la versión de Java en el fichero de configuración."
    pedir_dato "Introduce la versión de Java a instalar" \
                JAVA_VERSION \
               '^[0-9]{1,2}$' \
               "Versión no válida: Debe ser un número entre 8 y 24." \
               3 \
               "8-24" \
               "11"
    if (( $? != 0 )); then
        mostrar_mensaje_error "No se ha podido obtener una versión válida de Java. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "Versión de Java identificada: $JAVA_VERSION"
fi

echo "Identificando la versión de Tomcat."
if [[ -z "$TOMCAT_VERSION" ]]; then
    mostrar_mensaje_advertencia "No se ha definido la versión de Tomcat en el fichero de configuración."
    pedir_dato "Introduce la versión de Tomcat a instalar" \
                TOMCAT_VERSION \
               '^[0-9]+\.[0-9]+\.[0-9]+$' \
               "Versión no válida: Debe tener el formato X.Y.Z (por ejemplo, 9.0.65)." \
               3 \
               "X.Y.Z" \
               "9.0.65"
    if (( $? != 0 )); then
        mostrar_mensaje_error "No se ha podido obtener una versión válida de Tomcat. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "Versión de Tomcat identificada: $TOMCAT_VERSION"
fi

echo
mostrar_mensaje_informativo "Configuración final para la instalación:"
mostrar_mensaje_informativo "  Versión de Java:   ${RESET}$JAVA_VERSION" #11  (17)
mostrar_mensaje_informativo "  Versión de Tomcat: ${RESET}$TOMCAT_VERSION" #9.0.65
mostrar_mensaje_informativo "  Usuario de Tomcat: ${RESET}$TOMCAT_USER"
mostrar_mensaje_informativo "  Grupo de Tomcat:   ${RESET}$TOMCAT_GROUP"


# Solicitar confirmación
echo
pedir_dato "¿Desea continuar con la instalación con estos parámetros? (s/n)" \
            confirmar_instalacion \
           '^[sSnN]$' \
           "Respuesta no válida: Debe ser 's' o 'n'." \
           3 \
           "s/n" \
           "s"
if [[ ! "$confirmar_instalacion" =~ ^[sS]$ ]]; then
    mostrar_mensaje_error "Instalación cancelada por el usuario."
    exit 1
else
    mostrar_mensaje_exito "Continuando con la instalación..."
fi

# Primero de todo, asegurar que java está instalado

# Verificar si java está instalado
# Si no hay java instalado, instalar la versión que hemos definido en JAVA_VERSION
# Y vamos a sacar qué versión de java está instalada
# Si está nuestra version, la respetamos
# Si hay una versión inferior, instalamos la nuestra
# Si hay una versión superior, avisamos al usuario y le dejamos decidir si quiere instalar la más antigua o directamente usar la nueva
echo
mostrar_mensaje_informativo "Comprobando si Java está instalado en el sistema..."
version_actual_java=$(java -version 2>&1 )
if (( $? != 0 )); then
    mostrar_mensaje_advertencia "  Java no está instalado en el sistema."
    mostrar_mensaje_informativo "  Procedemos a instalar la versión $JAVA_VERSION de Java."
    apt install -y openjdk-$JAVA_VERSION-jdk
else # En este caso (SI HAY YA JAVA) tenemos que mirar si la versión nos vale
    # Lo que tenemos en este momento dentro de la variable version_actual_java es algo así:
    # openjdk version "11.0.28" 2025-07-15
    # OpenJDK Runtime Environment (build 11.0.28+6-post-Ubuntu-1ubuntu124.04.1)
    # OpenJDK 64-Bit Server VM (build 11.0.28+6-post-Ubuntu-1ubuntu124.04.1, mixed mode, sharing)
    # Nos interesa solo lo que hay entre las comillas de la primera línea
    version_actual_java=$( echo $version_actual_java | head -n 1 )  # openjdk version "11.0.28" 2025-07-15
    version_actual_java=${version_actual_java#*\"}  # 11.0.28" 2025-07-15
    # Solo me interesa el MAYOR VERSION (11 en este caso)
    mayor_version_actual_java=${version_actual_java%%.*}  # 11
    mostrar_mensaje_informativo "  Java está instalado en el sistema. Versión actual: ${RESET}$mayor_version_actual_java"
    # Tomar decisiones según la versión actual
    if (( $mayor_version_actual_java == $JAVA_VERSION )); then
        mostrar_mensaje_exito "  La versión instalada de Java es la requerida. No se realizarán cambios."
    elif (( $mayor_version_actual_java < $JAVA_VERSION )); then
        mostrar_mensaje_advertencia "  La versión instalada de Java es inferior a la requerida."
        mostrar_mensaje_informativo "  Procedemos a instalar la versión $JAVA_VERSION de Java."
        apt install -y openjdk-$JAVA_VERSION-jdk
    else
        mostrar_mensaje_advertencia "  La versión instalada de Java es superior a la requerida."
        pedir_dato "¿Desea instalar la versión $JAVA_VERSION de Java de todos modos? (s/n)" \
                    instalar_java \
                   '^[sSnN]$' \
                   "Respuesta no válida: Debe ser 's' o 'n'." \
                   3 \
                   "s/n" \
                   "s"
        if [[ "$instalar_java" =~ ^[sS]$ ]]; then
            mostrar_mensaje_informativo "  Procedemos a instalar la versión $JAVA_VERSION de Java."
            apt install -y openjdk-$JAVA_VERSION-jdk
        else
            mostrar_mensaje_informativo "  Se mantiene la versión actual de Java. Continuando con la instalación de Tomcat."
        fi
    fi
fi

echo
mostrar_mensaje_informativo "Creando grupo y usuario para Tomcat..."
# Crear usuario y grupo
# Revisar si el grupo ya existe
# getent: (get entries) consulta las bases de datos del sistema (usuarios, grupos, etc)
getent group $TOMCAT_GROUP 1> /dev/null 2>&1
                           # Ejecutamos el comando en modo silencioso... No va a verse nada por pantalla
if (( $? != 0 )); then
    mostrar_mensaje_informativo "  El grupo no existe. Creando el grupo $TOMCAT_GROUP..."
    groupadd $TOMCAT_GROUP
    # Este comando nos permite crear un grupo nuevo en el sistema
    if (( $? == 0 )); then
        mostrar_mensaje_exito "    Grupo $TOMCAT_GROUP creado correctamente."
    else
        mostrar_mensaje_error "    No se ha podido crear el grupo $TOMCAT_GROUP. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "  El grupo $TOMCAT_GROUP ya existe. No se crearán cambios."
fi
# Para los usuarios no hay una bbdd llamada "users", sino que están en la bbdd "passwd"
getent passwd $TOMCAT_USER 1> /dev/null 2>&1
if (( $? != 0 )); then
    mostrar_mensaje_informativo "  El usuario no existe. Creando el usuario $TOMCAT_USER..."
    useradd -M -s /bin/false -g $TOMCAT_GROUP $TOMCAT_USER
    # Nombre del usuario: $TOMCAT_USER
    # Nombre del grupo principal: -g $TOMCAT_GROUP
    # No crear carpeta de usuario para este usuario.. No es una persona real: -M
    # No permitir login para este usuario: -s /bin/false.. No es una persona real
    # Es un usuario que solo vamos a usar para ejecutar el servicio de tomcat
    if (( $? == 0 )); then
        mostrar_mensaje_exito "    Usuario $TOMCAT_USER creado correctamente."
    else
        mostrar_mensaje_error "    No se ha podido crear el usuario $TOMCAT_USER. Saliendo del instalador."
        exit 1
    fi
else
    mostrar_mensaje_exito "  El usuario $TOMCAT_USER ya existe. No se crearán cambios."
fi


echo
mostrar_mensaje_informativo "Descargando e instalando Tomcat versión $TOMCAT_VERSION..."
# Descargar tomcat
# Necesitamos la versión completa de tomcat: 9.0.65. La tenemos en la variable TOMCAT_VERSION
# El MAJOR también lo necesitamos: 9 y no lo tenemos guardado en ninguna variable
TOMCAT_MAJOR_VERSION=${TOMCAT_VERSION%%.*}  # 9
url="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"

# Para la descarga podemos usar el comando wget
# Dónde hacemos la descarga? Podemos usar /tmp
# /tmp en linux se borra automáticamente al reiniciar el sistema
carpeta_temporal="/tmp/tomcat_install"
archivo_descarga="$carpeta_temporal/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
mkdir -p $carpeta_temporal/descomprimido
# -p    hace 2 cosas
#   Crea la carpeta y las carpetas padre si no existen
#   En caso de que la carpeta ya exista, no da error
mostrar_mensaje_informativo "  Descargando Tomcat desde: ${RESET}$url"
wget -q -O $archivo_descarga $url
    # -q    modo silencioso (quiet)
    # -O    nombre del fichero de salida

if (( $? != 0 )); then
    mostrar_mensaje_error "    No se ha podido descargar Tomcat desde $url. Saliendo del instalador."
    exit 1
else
    mostrar_mensaje_exito "    Tomcat descargado correctamente."
fi
# Descomprimir tomcat
tar -xzf $archivo_descarga -C $carpeta_temporal/descomprimido
    # -x    extraer
    # -z    formato gzip
    # -f    fichero
    # -C    carpeta destino

if (( $? != 0 )); then
    mostrar_mensaje_error "    No se ha podido descomprimir Tomcat. Saliendo del instalador."
    exit 1
else
    mostrar_mensaje_exito "    Tomcat descomprimido correctamente."
fi

# Mover el descargado y descomprimido a /opt/tomcat

mostrar_mensaje_informativo "  Copiando Tomcat en /opt/tomcat ..."
directorio_instalacion="/opt/tomcat"
mv $carpeta_temporal/descomprimido/apache-tomcat-$TOMCAT_VERSION $directorio_instalacion
# Al tomcat hay que ponerle propietario su usuario y grupo
mostrar_mensaje_informativo "  Estableciendo permisos de usuario y grupo para Tomcat ..."
chown -R $TOMCAT_USER:$TOMCAT_GROUP $directorio_instalacion
mostrar_mensaje_exito "    Tomcat instalado correctamente en $directorio_instalacion."

echo
mostrar_mensaje_informativo "Configurando Tomcat como servicio del sistema (systemd)..."
# Crear un Unit file de systemd para ejecutar tomcat como servicio con:
cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Servidor de Aplicaciones Apache Tomcat
After=network.target

[Service]
Type=forking
User=${TOMCAT_USER}
Group=${TOMCAT_GROUP}

Environment="JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64"
Environment="JRE_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64"
Environment="CATALINA_HOME=${directorio_instalacion}"
Environment="CATALINA_BASE=${directorio_instalacion}"
Environment="CATALINA_TMPDIR=${directorio_instalacion}/temp"

ExecStart=${directorio_instalacion}/bin/startup.sh
ExecStop=${directorio_instalacion}/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
# cat << EOF ... EOF        Es como si fuera un echo que escribe varias líneas 
# Y lo que estamos haciendo es redirigir esa salida a un fichero llamado /etc/systemd/system/tomcat.service

mostrar_mensaje_exito "  Archivo de servicio creado en /etc/systemd/system/tomcat.service"

# Recargar los archivos de configuración de systemd
systemctl daemon-reload 1> /dev/null 2>&1
systemctl enable tomcat   # Habilitar el servicio para que arranque automáticamente al iniciar el sistema
mostrar_mensaje_exito "  Servicio de Tomcat configurado correctamente."

systemctl start tomcat    # Iniciar el servicio de tomcat
mostrar_mensaje_exito "  Servicio de Tomcat iniciado correctamente."

echo
mostrar_mensaje_informativo "Vamos a esperar unos segundos a que Tomcat arranque para probarlo..."
sleep 10   # Esperar 10 segundos
# ss -tlnp
# -t   Mostrar solo conexiones TCP
# -l   Mostrar solo puertos en escucha
# -n   Mostrar números de puerto en lugar de nombres
# -p   Mostrar el proceso que está usando el puerto

# Probar que Tomcat está funcionando
curl http://localhost:8080/ 1> /dev/null 2>&1
if (( $? == 0 )); then
    mostrar_mensaje_exito "Tomcat se ha instalado y está funcionando correctamente."
    mostrar_mensaje_informativo "Puede acceder a la página de bienvenida de Tomcat en: ${RESET}http://localhost:8080/"
else
    mostrar_mensaje_error "No se ha podido acceder a Tomcat. Verifique los logs para más información."
    exit 1
fi

# Fin del script

echo
mostrar_mensaje_informativo "Gracias por usar el instalador de Tomcat. ¡Hasta pronto!"