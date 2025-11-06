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

# Descargar tomcat
# Crear usuario y grupo
# Descomprimir tomcat
# Crear un Unit file de systemd para ejecutar tomcat como servicio con:
# - Usuario y grupo definidos
# - Variables de entorno JAVA_HOME y CATALINA_HOME
# Iniciar el servicio
# Lo programamos para que en el siguiente arranque del sistema se inicie automáticamente