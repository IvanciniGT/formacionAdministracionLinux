
# Contenedores

Un contenedor es un entorno aislado dentro de un SO con Kernel Linux donde ejecutar procesos.
Como entorno aislado:
- Tiene sus propias variables de entorno
- Su propio sistema de ficheros (FileSystem ... tiene su propio /)
- Tiene su propia configuración de red (IP, interfaces)
- Podemos tener limitaciones de recursos (CPU, RAM, etc)

Los contenedores los creamos desde imágenes de contenedores (Docker Images).

## Imágenes de contenedores

Es un triste archivo comprimido (tar) que contiene:
- Una estructura de carpetas compatible con posix (no es obligatorio... pero si lo habitual)
- En ella ponemos programas ya instalados de antemano.... con una configuración concreta
  Normalmente los fabricantes de software nos proporcionan imágenes oficiales... con el producto instalado y configurado por ellos.
- Además suelen traer otros programas instalados (librerías, utilidades, etc) para que el software funcione correctamente.
  O simplemente utilidades que me pueden venir bien para trabajar dentro del contenedor.
También en esa imagen viene un fichero de metadatos:
- Quién es el que la ha creado
- Qué software trae instalado
- Qué versión es
- Qué puertos de red usa
- Qué variables de entorno necesita
- Qué comando ejecutar al arrancar el programa que viene dentro del contenedor.
- ...

c:\miproyecto\ <<<<<<< Lo comprimo en un .tar
              bin\
              opt\
              etc\
              lib\
              var\
              home\
              ...

Instalación de SQL Server de Microsoft:
1. Descargar el INSTALADOR de SQL Server
2. (quizás previamente necesite hacer algunas configuraciones en el SO).. O montar algunas dependencias.
3. Ejecuto ese instalador (que puede ser más o menos complejo)
4. Esto da lugar a una instalación: c:\archivos de programa\sqlserver\... -> .zip -> email
5. Y ya puedo ejecutarla

Esas imágenes de contenedor las encontramos en Registros de Repositorios de Imágenes de Contenedor.
El más famoso se llama Docker hub.


Todas las operaciones con contenedores / imágenes se hacen con gestores de contenedores:
Docker, Podman, Crio, Containerd, etc.

docker  TIPO_DE_OBJETO VERBO                                Argumentos
        image          pull, rm, list
        container      create, rm, list, start, stop ....
        ...

Las imágenes de contenedor se identifican por una url:
   REGISTRO/REPOSITORIO:TAG
   docker.io /library/tomcat:9.0.111
   REGISTRY  REPOSITORY      TAG

En el tag se incluye habitualmente información como :
- La versión del software que trae instalado
- Las versiones de otras dependencias (En el caso del tomcat, qué versión de java trae instalado)
- Y otras.

Todos los gestores de contenedores traen por defecto configurados algunos registros públicos (como docker.io < Docker hub>).

Y en las URLs podemos evitar escribir esa parte... Ya el gestor de contenedores buscará ese Repositorio:etiqueta en los registros que tenga configurados por defecto.


---

Si vosotros estáis en Windows... y tenemos una VM Ubuntu
Si en el ubuntu instalo Tomcat y lo pongo a correr...
En el administrador de tareas del windows, vemos el tomcat? NO
Lo único que veo es a nivel del Windows el proceso del VirtualBox

Traído a contenedores:
Si en el ubuntu instalo docker y desde ahí levanto un contenedor con tomcat...
En el administrador de tareas del ubuntu (ps), vemos el tomcat? SI

Y es la diferencia con los contenedores...
Cuántos SO hay al trabajar con contenedores? SOLO 1..
Pues ese 1 es el que controla todos los procesos que hay en ejecución... por eso podrá ver todos los procesos.


---

POSIX define mecanismos para comunicarme con procesos.
Uno de ellos es mediante el envío dee señales (signals).
Y el estandar POSIX define una serie de señales estándar:
- 1 SIGHUP   -> Hang UP  -> Señal que se envía a un proceso cuando se cierra la terminal desde la que se lanzó.
- 2 SIGINT   -> Interrupt -> Señal que se envía a un proceso cuando se pulsa Ctrl+C en la terminal desde la que se lanzó.
- 3 SIGQUIT  -> Quit     -> Señal que se envía a un proceso cuando se pulsa Ctrl+\ en la terminal desde la que se lanzó.
- 9 SIGKILL  -> Kill     -> Señal que se envía a un proceso para forzar su terminación inmediata. No puede ser ignorada ni capturada.
- 15 SIGTERM -> Terminate-> Señal que se envía a un proceso para solicitar su terminación. Puede ser capturada para realizar una limpieza antes de terminar.    
- ... más señales


---

TODO TODO !!! TODO !!! TODO !!! ABSOLUTAMENTE TODO producto de software hoy en día (de carácter empresarial (no el word... ni el photoshop)) eestá disponible como contenedor.
Y de hecho es la forma favorita de instalación y despliegue de software hoy en día.

Microsoft ha hecho una apuesta total por los contenedores... y por linux!

Antiguamente tenía su propio framework de desarrollo de software empresarial: .NET Framework
Cuando llegó Sataya Nadella a la presidencia de Microsoft, decidió apostar por el Open Source y por Linux, migró (un proceso de unos 3 años) todo su framework a un nuevo framework llamado .NET Core (hoy en día .NET 7, .NET 8, etc).
Ese framework es open source y multiplataforma (Windows, Linux, MacOS).

SQL Server hoy en día funciona perfecto sobre Linux... y Microsoft distribuye SQL Server como contenedor Linux.

Contenedores
Docker
Podman

> Si pone kubernetes huir de ello... por ahora... primero CONTENEDORES : FUNDAMENTOS!
  Si luego me voy a dedicar a la Administración de sistemas -> Kubernetes
  Si soy desarrollador, quiero aprender contenedores, pero no kubernetes.

Kubernetes es una herramienta para diseñar/operar entornos de producción basados en contenedores.
VMWare VSphere ~ Kubernetes
   VMs           Contenedores


Kubernetes: Lo que se configuran son:
- Reglas de firewall
- Reglas de balanceo de carga
- Escalado automático
- Monitorización
- Alta disponibilidad
- Persistencia de datos (Volumenes compartidos entre contenedores)

Openshift es una distro de kubernetes.

Hay muchas. Kubernetes es un proyecto opensource.
Muchas empresas toman la base de kubernetes y le ponen por encima sus aventuras.
Dan kubernetes vitaminados (edulcorados).
- RedHat -> Openshift
- Rancher Labs -> Rancher
- VMware -> Tanzu
- Nutanix -> Karbon
- Amazon -> EKS
- Google -> GKE
- Microsoft -> AKS
- ...
Hoy en día, todos los entornos de producción o están ya en kubernetes o están migrando a kubernetes.

Kubernetes es quien opera los entornos de producción... ya no tengo sysadmins operando los entornos de producción.
Eso lo hace Kubernetes.

No puedo meterme en kubernetes hasta que no sepa un huevo de contenedores!


---

Nuestro script de instalación de tomcat en ubuntu:
1. Instalar JAVA 
2. Creábamos usuario y grupo
3. Instalar Tomcat
4. Configurábamos servicios


Al trabajar con contenedores, nada de eso tiene sentido ya.
Es decir, eso ya lo ha hecho la gente de Apache.
Lo único que hago es descomprimir un zip (tar) y arrancar el contenedor..
Y cuidao.. que no tengo ni porque saber como se arranca el programa:
  $ docker container start NOMBRE_CONTENEDOR


Ese nivel de estandarización es lo que permite que esas tareas (arrancar, parar, instalar-desplegar-, desinstalar, reiniciar...) las automaticemos = KUBERNETES

Todo eso ya no me es necesario... a no ser que!
 Voy a encontrar imágenes de contenedor de TODO PRODUCTO COMERCIAL.
Y si hay un producto que fabrico yo? In house? Evidentemente para mi producto no hay una imagen oficial.
Entonces tendré que crear yo mismo la imagen de contenedor de mi producto.
Y tendré que hacer yo, todo eso... básicamente crear un script de instalación, como el que hemos hecho del tomcat!

Esto es una tarea habitual de ese perfil que hoy en día denominamos DevOps Engineer.

---

Un curso es: Docker / Container Fundamentals
Y otro: Creación de imágenes de contenedor personalizadas con Docker


---


Al crear un contenedor, hay muchas configuraciones que necesitamos establecer:
- Tengo una BBDD que estoy montando. Qué usuario? qué contraseña? Como se llama la BBDD?
  Esos datos no los puede decidir el fabricante de la imagen!
     Todo esto se configura vía variables de entorno
- El puerto me la trae el peiro. NO LO TOCO NUNCA. Antees pudiera ser que necesitase tocarlo... para que no entrase en confñicto con otro programa que tenía en mi máquina usando ya ese puerto.
  Con contenedores, como cada conteenedor tiene su IP, nunca hay conflictos de puertos.
- La IP del contenedor, me la trae al peiro. Nunca la toco yo... la que lee toque.. me da igual!
  Estas herramientas lo que me permiten es hacer NAT (redirección de puertos) desde la IP del host a la IP del contenedor.
  Lo que me permiten es asignar un puerto en la IP(IPs) del host (mi máquina física o VM) que cuando llame ahí, son redirigidas al puerto del contenedor.
- Los datos que se guardan dentro de un contenedor (en su FileSystem) normalmente no los quiero ahí... Los quiero en otro sitio.
Cuando trabajamos con Docker (que es uina herramienta pensada para entornos locales (donde no necesitamos HA: High Availability)), lo que hacemos es montar volúmenes que realmente apuntan al sistema de ficheros del host.
       ES DECIR, COMPARTIMOS CARPETAS DEL HOST CON EL CONTENEDOR... igual que hemos hecho con las VMs.

       MariaDB -> /var/lib/mysql  del fs del contenedor
       Pero yo pido que esa carpeta del contenedor, realmente sea una carpeta del host: c:\usuario\yo\datos\mariadbdata

    docker container create \
       --name mariadb01 \
         -e MARIADB_ROOT_PASSWORD=MiPasswordSegura \
         -e MARIADB_DATABASE=MiBaseDeDatos \
         -e MARIADB_USER=usuariobd \
         -e MARIADB_PASSWORD=OtraPasswordSegura \
         -p 3306:3306 \
         -v c:\usuario\yo\datos\mariadbdata:/var/lib/mysql \
         --cpu 2 \
         --memory 2g \
         mariadb:10.11


    docker run -d --name mitomcat tomcat:9.0.111
     = Ese comando que yo he usado es trampa... hace muchas cosas:
           docker image pull tomcat:9.0.111
           docker container create --name mitomcat tomcat:9.0.111
           docker container start mitomcat


    docker-compose.yaml