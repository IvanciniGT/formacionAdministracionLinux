
# Qué es Linux?

No es un Sistema Operativo! Es un kernel de sistema operativo.

Un Sistema Operativo no es un programa que instalo. En realidad son miles de programas trabajando juntos. 
Todo sistema operativo tiene unos cuantos programas comunes que siempre encontramos:
- Un cargador: Loader de Sistema Operativo
- Kernel: Núcleo del Sistema Operativo (Esta es la parte más compleja)
- Shells: Una shell es un programa que nos permite comunicarnos (a nosotros humanos) con el sistema operativo:
  - Shells tipo interfaz gráfica (GUI)
  - Shells tipo línea de comandos (CLI)
- Drivers
- Utilidades: Administrador de archivos de windows, administrador de tareas, etc.

# Qué es Windows?

No es un Sistema Operativo! Es una familia de Sistemas Operativos desarrollados por Microsoft:
- Windows 3.1
- Windows 95
- Windows 98
- Windows ME
- Windows NT
- Windows Servers
- Windows XP
- Windows Vista
- Windows 7
- Windows 8
- Windows 10
- Windows 11

# Los Sistemas Operativos Windows ... tiene kernel?

Claro! Todos tienen kernel. Microsoft ha usado 2 kernels en su historia para crear TODOS sus sistemas operativos:

- DOS -> Usado en MSDOS, Windows 3.1, 95, 98, ME
- NT (New Technology) -> Usado en Windows NT, 2000, XP, Vista, 7, 8, 10, 11 y todos los Windows Servers.
---

# Qué era Unix?

Era un Sistema Operativo, que creaba la gente de la americana de telecomunicaciones AT&T en los años 70s (división Labs Bell).

Estaban trabajando en un SO llamado MULTICS (Multi-User Time-Sharing System). Fué un desastre ese proyecto... y era muy lento. Lo iban a abandonar. Uno de los programadores, Ken Thompson, enfadado porque un juego que había creado para MULTICS tardaba literalmente horas en cargar, empezó a meterle la tijera a MULTICS.... Y acabo con un SO mucho más simple y rápido. Le llamó UNICS (Uniplexed Information and Computing Service). En inglés esa palabra se pronuncia igual que EUNUCOS (EUNUCHS). Así que luego le cambiaron el nombre a UNIX.

Eso empezó a cuajar... y comenzaron a licenciarlo,.. Antiguamente los SO se licenciaban de forma diferente a cómo se hace hoy en día (EULA - End User License Agreement). UNIX se empezó a licenciar a universidades y grandes empresas.Y aquellos tuneaban el SO para adaptarlo a su propio HARDWARE (hardware específico). Problemón: Llegó a haber más de 400 versiones diferentes de UNIX. Muchas de ellas incompatibles entre sí.

Hubo que meterle mano a eso y crearon (surgieron) dos estándares en la industria para intentar controlar cómo debían evolucionar los sistemas operativos UNIX:
- POSIX (Portable Operating System Interface): Estándar abierto creado por IEEE (Institute of Electrical and Electronics Engineers). Define una serie de APIs (Application Programming Interfaces) que deben cumplir los sistemas operativos UNIX.
- SUS: Single UNIX Specification: Estándar creado por The Open Group. Define una serie de requisitos que debe cumplir un sistema operativo evolucionado de UNIX.

UNIX, como sistema operativo, dejó de fabricarse a principios de los 2000. Pero sin duda ha sido el referente y el SO más influyente en la historia de la informática.

# Qué es Unix?

Hoy en día al usar la palabra UNIX, no nos referimos a un sistema operativo sino a cualquier sistema operativo que cumpla con esos 2 estándares (POSIX y SUS).

Los grandes fabricantes de HW, crean, para sus máquinas más potentes sus propios Sistemas operativos:
- IBM: AIX (UNIX®)
- HP: HP-UX (UNIX®)
- ORACLE: Solaris (UNIX®)
- APPLE: macOS (UNIX®)

Esa certificación CUESTA PASTA! No es gratis.
Y a lo largo de la historia, pequeños y grandes colectivos/empresas han tratado de crear Sistemas operativos gratuitos. Y algunos de ellos, optaron por seguir estos estándares.

- Universidad de Berkeley en California: BSD386 (Berkeley Software Distribution). La cagaron estrepitosament: Al decir que tenían un SO UNIX.. denuncia! de la gente de AT&T. La base del código del BSD si se usó posteriormente para crear otros SO como FreeBSD, OpenBSD, NetBSD, macOS.

- GNU: Richard Stallman, en 1983, empezó el proyecto GNU (GNU's Not Unix). Quería crear un sistema operativo libre, gratuito y abierto. Pasaron muchos años.. crearon de todo lo que tenía que tener un SO:
  - Editor de texto: Gedit
  - Compiladores: GCC
  - Shells: Bash
  - Entornos gráficos de ventanas: GNOME
  - Juegos: Chess
  - No valieron para una pieza: KERNEL

En medio de todo ese caos... y a la falta de un Sistema operativo inspirado en UNIX pero gratuito, un hombrecillo de la universidad de Helsinki (Finlandia), Linus Torvalds, en 1991, se metió un fin de semana en su cabaña.. y 7 millones de líneas de código después... creó un kernel supuestamente compatible con las especificaciones POSIX y SUS: LINUX

Se juntó la gente de GNU con Linus Torvalds y crearon un Sistema Operativo completo: GNU/LINUX.

GNU / Linux si es un Sistema Operativo completo, gratuito, libre y abierto, supuestamente inspirado en UNIX... en sus orígenes... hoy en día LINUX lleva su propio camino de desarrollo, ajeno totalmente a los estándares POSIX y SUS (que siguen evolucionando).

Ese SO GNU/Linux, es al que habitualmente llamamos LINUX. Y el propio Linus Torvalds dice que no deberíamos hacer eso, ya que estamos haciendo un feo muy grande a la gente de GNU, que se estima que aportaron en torno al 70% del código total del sistema operativo.

Ese Sistema operativo se suele adquirir por parte de la gente / Empresas en forma de distribuciones (DISTROS). Las DISTROS son versiones empaquetadas del sistema operativo GNU/Linux, que incluyen además del kernel LINUX, las utilidades GNU y otros programas adicionales (entornos gráficos, navegadores web, suites ofimáticas, drivers...) que se empaquetan juntos por diferentes colectivos/empresas para facilitar su instalación y uso de ese sistema operativo:
-> Debian
  -> Ubuntu (Canonical)
-> Redhat:
  -> Redhat Enterprise Linux (RHEL)
  -> Fedora
  -> CentOS
-> SUSE

Tenemos claro, cuál es el kernel de SO más usado del mundo? LINUX! muchos ordenes de magnitud con respecto a NT. Linux se usa para montar muchos SO... y nosotros hemos hablado de 1 de ellos: GNU/Linux. otro SO que usa el kernel de Linux, y que por si solo convierte a Linux en el kernel de SO más usado del mundo es Android (Google). Android usa el kernel de Linux, pero no usa nada de GNU.

Y qué piensa Microsoft de todo esto? Están encantados! La apuesta de Microsoft por el mundo opensource, y por Linux es enorme.
A todos los niveles:
- Azure (la nube de Microsoft)  el so principal es GNU/Linux
- En windows hoy en día puedo poner a funcionar en paralelo con el kernel NT un kernel Linux (WSL - Windows Subsystem for Linux) -> Soportar Contenedores!
- TFS -> GIT

---

Lo primero entonces que vamos a hacer no es hablar de Linux... sino de POSIX. 
Muchas de las características de Linux (GNU/Linux) vienen de POSIX.... de las primeras especificaciones de POSIX:
- Estructura del sistema de archivos:
   /
    bin/
    opt/
    etc/
    home/
    ...
- Permisos de archivos y usuarios
- Señales
- Procesos y gestión de procesos
- Entrada/Salida estándar
- Tuberías (Pipes)
- Redirecciones 

---

En general, los SO Windows tendemos a usarlos desde ventanitas, botones, formularios...
Aunque en los SO GNU/Linux también tenemos entornos gráficos de ventanas (GNOME, KDE, XFCE...) en la mayoría de los casos, ni los instalamos, ni los queremos. Por qué?

Las operaciones que hacemos sobre ventanas NO SON AUTOMATIZABLES!
Por contra, los comandos que ejecuto en una terminal SI SON AUTOMATIZABLES! -> SCRIPT!
Y esto es lo que adoramos de trabajar con terminales. Más aún hoy en día.

---

# Qué es DEVOPS? (Development + Operations)

Es una cultura, un movimiento, una filosofía, en pro de la AUTOMATIZACIÓN de TODOS los procesos entre el DEV -> OPS


Ese camino le vamos recorriendo... poco a poco.

En muchas de las etapas de DEVOPS, lo que haremos es trabajar en entornos GNU/Linux.


---

# Automatizar

Crear una máquina (o cambiar el comportamiento de una mediante programas) de forma que haga el trabajo que antes era realizado por un humano.

Automatizar el lavado de la ropa: LAVADORA (personalizar con programas: Programa de frio, prendas delicadas, etc).

En nuestro caso, la máquina ya la tenemos: COMPUTADORA.
Lo que vamos a hacer son programas que hagan el trabajo que antes hacía un humano.

Los desarrolladores antes compilaban y empaquetaban su código manualmente. Hoy en día usan herramientas para ello:
- Java: MAVEN, GRADLE
- .NET: MSBUILD, NUGET, Dotnet
- JS: NPM, YARN, WEBPACK

Los testers antes hacían pruebas a los sistemas. Hoy en día su trabajo es crear programas que prueben otros programas:
- Selenium, Cypress, JUnit, NUnit, SonarQube, JMeter, etc.

Los administradores de sistemas antes administraban sistemas. Hoy en día, su trabajo es crear programas que administren sistemas:
- Ansible, Puppet, Chef.
- Terraform, CloudFormation.
- Docker, Kubernetes.
- Script de la bash o la powershell.
- ...

Ahora... como toda automatización se hace en 2 niveles:
- Una cosa es automatizar las tareas básicas (unitarias)
- Otra cosa es automatizar la ejecución orquestada de todas esas tareas: Servidores de Automatización (CI/CD): Jenkins, Azure DevOps, GitHub Actions, GitLab CI, Travis, Bamboo, etc.

Este es el segundo nivel de automatización. Eso lo hacemos montando otro tipo de programas que son los pipelines de automatización: CI/CD (Integración Continua / Despliegue Continuo). Creando scripts(pipelines) en herramientas como Jenkins, Azure DevOps, GitHub Actions, etc.

Ese trabajo antes no se hacía... y no tenía a nadie que supiera hacerlo. Ha sido necesario un nuevo perfil en el mundo IT: EL INGENIERO DE DEVOPS.

El devops (como perfil) es el que configura los circuitos de automatización (pipelines) en las herramientas de CI/CD.

En muchas empresas se ha pervertido el uso de la palabra devops como perfil... pasando a usarse para cualquier Administrador de Sistemas que use herramientas de automatización (Ansible, Terraform, Docker, etc). Eso no es devops. Eso es un administrador de sistemas v2.0 ( moderno).


Esas automatizaciones, desde el punto de vista de Sistemas, se hacen en entornos GNU/Linux (bien en servidores -físicos o virtuales-, como se ha hecho tradicionalmente, bien en contenedores -Docker- como se hace hoy en día).
Y eso nos exige conocimiento profundo de GNU/Linux.

Automatizar no me quita de saber Linux.... me exige saber más de Linux.

---

# Sistema de archivos en GNU/Linux (herencia POSIX)

La primera diferencia grande que encontramos con respecto a Windows en el sistema de archivos:
- Windows crea unidades de disco lógicas (que pueden ir asociadas a 1 o más discos físicos):
  - C:\
  - D:\
  - E:\
  - F:\

Algunas de esas unidades de disco, incluso pueden apuntar a discos de red (UNC - Universal Naming Convention):
  - X:\ -> \\Servidor\RecursoCompartido

En Linux (POSIX) el concepto es diferente. Tenemos el concepto de FileSystem: Sistema de archivos. Es un concepto lógico que agrupa todos los discos físicos y lógicos en un único árbol de directorios (estructura jerárquica en forma de árbol).
En windows, cada unidad de disco lógica es independiente de las demás. En Linux, todo está unido en un único árbol de directorios.

La raíz de ese árbol de directorios es el directorio / (ROOT).
A partir de ahí, tenemos una serie de directorios estándar heredados de POSIX:

   bin/        -> Binarios esenciales del sistema (comandos básicos)
                     ls, cp, mv, rm, cat, echo, ps, kill, etc. ( A su vez, éstos comandos vienen definidos en POSIX)
   home/       -> Directorios personales de los usuarios (El equivalente a C:\Users\ en Windows)
                     /home/usuario1/
                     /home/usuario2/
   de casi todos los usuarios... salvo 1: root (administrador del sistema)
   root/
   etc/        -> Ficheros de configuración del sistema operativo y de programas instalados.
   var/        -> Los archivos que van generando los programas (logs, bases de datos, etc)
   opt/        -> Programas opcionales (software de terceros)
   usr/        -> Programas y utilidades instaladas en el sistema (software de terceros).   
                  Básicamente es cómo en windows  c:\Program Files\ y la c:\Program Files (x86)\
   mount/      -> Punto de montaje de dispositivos (discos duros, memorias USB, CD/DVD, etc)
   dev/        -> Dispositivos del sistema (discos, impresoras, puertos...)
   proc/       -> Información de ejecución del sistema (procesos, memoria, CPU...)
   tmp/        -> Ficheros temporales (se suelen borrar al reiniciar el sistema)

Es importante separar entre:
- Dispositivo     <- Disco físico
- Volumen         <- Disco lógico (la unión de 1 o más dispositivos físicos... o particiones)
- Partición       <- Porción de un dispositivo lógico
- Formato         <- Sistema de archivos con el que se formatea una partición (FAT32, EXT4, ZFS, etc)
                     Tiene que ver con la estructura interna lógica con la que se organizan los datos en disco.

Un disco es como un cuaderno en blanco.
En las clases de matemáticas, me interesaría un cuaderno en blanco? Cuadriculado!
En las clases de lengua o historia: líneas
En las clases de lengua... siendo más pequeños, doble línea.
Si quiero hacer dibujos de estadísticas: Milimetrado.

Es el mismo concepto. Cuando compro un HDD viene en blanco.. no lo compro ya con líneas por dentro de ningún tipo... Se las pinto después: Esos son los formatos de disco.

# Permisos en GNU/Linux (herencia POSIX)

El sistema operativo nos ayudará a controlar usuarios.
Esos usuarios pertenecerán a 1 o más grupos.

Con respecto al sistema de archivos, cada entrada en el sistema de archivos (archivo o directorio) tendrá unos permisos asociados:
- A nivel del usuario propietario
- A nivel del grupo propietario
- A nivel del resto de usuarios

Todo archivo, directorio... tendrá un usuario propietario y un grupo propietario.

Para cada uno de esos 3, se especifican 3 permisos básicos:
- r -> read -> Permiso de lectura
- w -> write -> Permiso de escritura
- x -> execute -> Permiso de ejecución (o acceso en el caso de directorios)

Internamente, Posix define que esos datos se almacenen en 3 bits:

   Usuario    Grupo      Resto
  [ ][ ][ ]  [ ][ ][ ]  [ ][ ][ ]
   R. W. X.   R. W. X.   R. W. X.

   0 - No permiso
   1 - Permiso concedido

   A priori, cuántas combinaciones puede haber en 3 bits? 2^3 = 8 combinaciones posibles
    0 - 000 - Sin permiso para hacer nada
    1 - 001 - Permiso de ejecución
    2 - 010 - Permiso de escritura
    3 - 011 - Permiso de escritura y ejecución
    4 - 100 - Permiso de lectura
    5 - 101 - Permiso de lectura y ejecución
    6 - 110 - Permiso de lectura y escritura
    7 - 111 - Permiso total (lectura, escritura y ejecución)

    Con esos números es con los que podemos establecer los permisos... y muchas veces los vemos representados así:
     /home/usuario1/  ->  755          Cómo lo interpreto?
        Usuario: 7 -> rwx -> Permiso total
        Grupo:   5 -> r-x -> Permiso de lectura y ejecución
        Resto:   5 -> r-x -> Permiso de lectura y ejecución

    No me hace falta aprenderlos todos:
      1 - Ejecución
      2 - Escritura
      4 - Lectura

    Y ahí ya la combinación que quiera:
     Lectura y escritura -> 4 + 2 = 6
     Lectura y ejecución -> 4 + 1 = 5
     Escritura y ejecución -> 2 + 1 = 3

        R. W. X.
        4  2  1

  Si un usuario es propietario de un archivo, tendrá los permisos que le correspondan en la primera parte (usuario).
  Si no es propietario, pero pertenece al grupo propietario del archivo, tendrá los permisos que le correspondan en la segunda parte (grupo).
  Si no es propietario, ni pertenece al grupo propietario, tendrá los permisos que le correspondan en la tercera parte (resto).

Algunos comandos básicos para trabajar con el sistema de archivos y permisos en GNU/Linux:
- ls              -> list: Listar el contenido de un directorio... o los detalles de un archivo/directorio
      ls /home/usuario1/     -> Listo el contenido del directorio usuario1
      ls /home/usuario1/miArchivo.txt  -> Listo los detalles del archivo miArchivo.txt

  A priori el único detalle que me da es el nombre del archivo/directorio:
   -l        -> Listar en formato largo (más detalles: tamaño, permisos, propietario, grupo, fecha de modificación, etc)
   -a        -> Listar también los archivos/carpetas ocultos (los que empiezan por '.')

- ll             -> Es un alias común en muchas distribuciones para hacer un ls -l
- cd             -> change directory: Cambiar de directorio
      cd /home/usuario1/     -> Me muevo al directorio usuario1
      cd ..                  -> Subo un nivel en el árbol de directorios
      cd ~                   -> Me muevo a mi directorio personal (/home/usuarioX/)

          ~ -> Representa el directorio personal del usuario actual -> /home/miUsuario/

      cd -                   -> Vuelvo al directorio anterior en el que estaba
           cd /etc/apache2/conf.d/
           cd ~            
           cd -             -> Vuelvo a /etc/apache2/conf.d/
- pwd            -> print working directory: Mostrar el directorio actual en el que estoy
- mkdir          -> make directory: Crear un nuevo directorio
      mkdir /home/usuario1/MisDocumentos/
- rmdir          -> remove directory: Borrar un directorio vacío
- rm             -> remove: Borrar un archivo o directorio (y su contenido)
      rm /home/usuario1/MisDocumentos/miArchivo.txt
      rm -r /home/usuario1/MisDocumentos/    -> Borrar el directorio y subdirectorios dentro (-r -> recursivo)
      Si el directorio tiene archivos dentro, me hará falta forzar el borrado:
        rm -rf /home/usuario1/MisDocumentos/   -> Borrar el directorio y todo su contenido forzadamente (-f -> force)
- touch         -> Crear un archivo vacío 
      touch /home/usuario1/MisDocumentos/miArchivo.txt
- cp            -> copy: Copiar un archivo o directorio
      cp /home/usuario1/MisDocumentos/miArchivo.txt /home/usuario                  Copiar un archivo
          ORIGEN                                     DESTINO
      Algunos modificadores de interés:
        -r     -> Copiar recursivamente (para copiar directorios y su contenido)     
        -p     -> Preservar los permisos y propietario del archivo/directorio copiado
- mv            -> move: Mover o renombrar un archivo o directorio
      mv /home/usuario1/MisDocumentos/miArchivo.txt /home/usuario1/MisDocumentos/miArchivoRenombrado.txt
      mv /home/usuario1/MisDocumentos/miArchivoRenombrado.txt /home/usuario2/MisDocumentos/
          ORIGEN                                              DESTINO
- chmod         -> change mode: Cambiar los permisos de un archivo o directorio

      chmod PERMISOS RUTA

      chmod 755 /home/usuario1/MisDocumentos/miArchivo.txt
      chmod u+x /home/usuario1/MisDocumentos/miArchivo.txt     Añade permiso de ejecución al usuario propietario
      chmod g-w /home/usuario1/MisDocumentos/miArchivo.txt     Quita permiso de escritura al grupo propietario
          u -> usuario
          g -> grupo
          o -> resto
          + -> añadir permiso
          - -> quitar permiso
- chown         -> change owner: Cambiar el usuario propietario y/o grupo propietario de un archivo o directorio

      chown USUARIO:GRUPO RUTA

      chown usuario2:grupoA /home/usuario1/MisDocumentos/miArchivo.txt
      chown usuario2 /home/usuario1/MisDocumentos/miArchivo.txt        Cambia sólo el usuario propietario
      chown :usuario2 /home/usuario1/MisDocumentos/miArchivo.txt       Cambia sólo el grupo propietario

  Tanto a chmod, como a chown, les puedo añadir el modificador -R para que actúen recursivamente sobre un directorio y todo su contenido.
  Y OJO... en este caso es R MAYÚSCULAS!
  
    chmod 777 -R /home/usuario1/MisDocumentos/   -> Cambia los permisos de todo el directorio y su contenido

RESUMEN:
- ls       .. Listar archivos y directorios
- cd       .. Cambiar de directorio
- pwd      .. Mostrar directorio actual
- mkdir    .. Crear directorio
- rmdir    .. Borrar directorio vacío
- rm       .. Borrar archivo o directorio
- touch    .. Crear archivo vacío
- cp       .. Copiar archivo o directorio
- mv       .. Mover o renombrar archivo o directorio
- chmod    .. Cambiar permisos de archivo o directorio
- chown    .. Cambiar propietario y/o grupo de archivo o directorio

Con respecto a archivos, hay algunos comandos adicionales de interés:
- cat       .. Mostrar el contenido de un archivo de texto por pantalla
- tac       .. Mostrar el contenido de un archivo de texto por pantalla, pero al revés (de la última línea a la primera)
- more      .. Mostrar el contenido de un archivo de texto por pantalla, de forma paginada (con las espacio haré scroll)
- head      .. Mostrar las primeras líneas de un archivo de texto
      head -n 20 miArchivo.txt    -> Mostrar las primeras 20 líneas del archivo 
- tail      .. Mostrar las últimas líneas de un archivo de texto
      tail -n 20 miArchivo.txt    -> Mostrar las últimas 20 líneas del archivo 
      tail -f miArchivo.log       -> Mostrar las últimas líneas del archivo y se queda a la espera de nuevas lineas que se vayan añadiendo (útil para logs)

En algunos casos me interesa también (aunque no siempre viene preinstalado en la distro):
- tree      .. Mostrar el contenido de un directorio en forma de árbol (con subdirectorios y subarchivos incluidos)

---

Nuestro sistema operativo... y en concreto el kernel se encarga de muchas tareas:
- Gestión de servicios: procesos que se ejecutan en segundo plano (daemons)
- Los puntos de montaje de los dispositivos físicos/lógicos (locales o en red)
- Los programas que deben ejecutarse y en qué orden cuando arranca el sistema (init system)
- ....

Antiguamente, en GNU/Linux, heredado de UNIX (SystemV), se usaba un sistema de init files (RC - Run Commands). Esto murió... eso ya no se usa. Hoy en día, en linux encontramos el demonio de sistema: systemd. Y todas estas operaciones son realizadas por systemd.

Contra el demonio del sistema hablamos usando un cliente llamado systemctl -> Controlador del demonio del sistema.
Es un cliente que nos permite pasar instrucciones al demonio del sistema (systemd).

Ese demonio de sistema se alimenta de unos ficheros llamados unidades (units files). Son ficheros de texto plano... muy sencillos.
Nos sirve para especificar:
- Servicios (services)
- Montajes de dispositivos (mounts)
- Puntos de Automontaje (automounts)
- Los modos de arranque del sistema (targets) (lo que antes se llamaba runlevels: 0-6)

IMPORTANTE: Esto no aplica a CONTENEDORES.... ya que en un contenedor los procesos se ejecutan en primer plano. 

---

# Unit file para Servicios (services)

```bash
[Unit]
Description=Descripción del servicio
# Con esto indicamos el orden de arranque de los servicios. En este caso, indicamos que para este servicio, necesitamos tener ya configurada la red.
After=network.target

[Service]
Type=simple 
# La forma en la que el proceso se va a ejecutar: simple, forking, oneshot, idle

# Este es el comando que arranca el programa en cuestión (Oracle, MySQL, Tomcat, Nginx, Apache, etc)
ExecStart=/usr/bin/miServicio
ExecStop=/usr/bin/miServicioStop

# Si el proceso finaliza con un código de error, lo volvemos a arrancar automáticamente
Restart=on-failure
# Otros valores posibles: no, always, on-success

User=miUsuario
Group=miGrupo
WorkingDirectory=/ruta/de/trabajo/del/servicio

Environment="VAR1=valor1" "VAR2=valor2"

```

Estos archivos habitualmente los colocaremos en la carpeta /etc/systemd/system/.
En ocasiones, por tener aquello un poco más organizado, crearemos subcarpetas dentro de /etc/systemd/system/ para agrupar los unit files por tipos de servicios.
Estos archivos van a tener extensión .service (aunque no es obligatorio, pero si es un convención muy usada).

Estos archivos, para que el demonio de sistema entienda que los debe procesar, es necesario hacerles una recarga al demonio del sistema:
```bash
systemctl daemon-reload
```

Eso hace que si hemos creado archivos nuevos, que los identifique automáticamente.

Y a partir de ese momento ya podemos controlar esos servicios con el comando systemctl:
```bash
# Arrancar el servicio. Ojo... Ese miServicio es el nombre del unit file (con o sin la extensión .service)
systemctl start miServicio.service
systemctl stop miServicio        # Parar el servicio
systemctl restart miServicio     # Reiniciar el servicio si estaba ya corriendo, o de lo contrario arrancarlo
systemctl status miServicio      # Me informa del estado del servicio (si está corriendo, si ha fallado, etc)
systemctl enable miServicio      # Habilitar el servicio para que arranque automáticamente con el sistema
                                 # Yo puedo haber hecho un start. Y que el servicio esté corriendo.
                                 # Pero, si no hago un enable, cuando reinicie el sistema, el servicio NO se arrancará automáticamente.
systemctl disable miServicio     # Deshabilitar el arranque automático del servicio con el sistema
```

Por defecto, cuando creamos uno de estos archivos, el servicio queda:
- Disabled (no arranca automáticamente con el sistema)
- Stopped  (no está corriendo)

Esas cosas he de pedírselas yo explícitamente con systemctl enable/start.
El hecho de hacer un enable, no hace que el servicio arranque en ese momento... sólo hace que arranque automáticamente con el sistema en el futuro.

Si acabo de instalar algo y quiero:
- Por un lado ponerlo en marcha
- Y hacer que arranque automáticamente con el sistema en el futuro
Debo explicitamente ejecutar:

```bash
systemctl enable --now miServicio
systemctl start miServicio   
``` 

Veremos que hay muchos programas en GNU/Linux, que cuando se instalan automáticamente crean su unit file en /etc/systemd/system/ y hacen un enable y un start automáticamente.

No siempre... y no siempre que se crean lo hacen con la configuración que yo quiero.

Hoy en día, con herramientas tipo ChatGPT, es muy sencillo crear estos unit files para cualquier servicio.
Nos lo dan entero hecho. No tengáis miedo de usar esas herramientas para crear estos archivos. Son herramientas que tenemos hoy en día a nuestro alcance, y hay que usarlas... Aunque no hay que confiar ciegamente en ellas. Hay que revisar lo que generan.

---

Ejecución de procesos dentro del sistema operativo GNU/Linux

Cuando arrancamos un programa, creamos un proceso dentro del SO.
De hecho, nosotros no arrancamos programas, quien lo hace es el kernel del sistema operativo.
Nosotros le pedimos al kernel que arranque un programa (mediante un comando... haciendo clic sobre un icono) y el kernel
lo primero que hace es crear un proceso en memoria para ese programa.
Todo proceso comienza y cuando termina arroja un código de salida (exit code).
Ese exit code puede ser :
- 0 -> El proceso ha terminado correctamente
- distinto de 0 -> El proceso ha terminado con errores
                   Dependiendo del programa, cada código de error puede significar una cosa diferente.
El demonio de sistema, cuando lanza un servicio para su ejecución, es capaz de monitorizar el proceso que ha arrancado.
Incluso puedo configurar el demonio del sistema para que si se detecta qe un proceso ha caído (ha terminado con error), lo vuelva a arrancar automáticamente.

Para ello, el demonio de sistema mira el exit code del proceso.
Mientras no hay un exit code, significa que el proceso sigue vivo.
Una vez se genera un exit code, el proceso ha terminado... bien o mal... dependiendo del exit code.

Hay programas que cuando los arranco, se quedan corriendo .
Pero hay casos donde cuando lanzo un programa, ese programa a su vez lanza otros procesos (hijos) y el proceso padre termina.

Por ejemplo: Imaginemos que quiero arrancar un nginx (servidor web).
Si ejecuto el comando de nginx, ese comando da lugar a un proceso que queda corriendo hasta que lo paro o hay un error.

Pero... quizás lo que preparo es un script que:
- Descarga de un repositorio el código de una web
- Descomprime el código en una carpeta
- Arranca el servidor web nginx para que sirva esa web

Y lo que configuro como servicio en el demonio del sistema es ese script.... y no el nginx.
Y el problema es que ese script acaba de ejecutarse... no se queda de perpetua corriendo. El que se queda es un proceso que se abrió dentro del script: El nginx.

En este caso, no me interesa que el demonio del sistema monitorice el script (proceso padre).... sino que monitorice el nginx (proceso hijo). Estas cosas son las que podemos configurar con el atributo Type= del unit file.
- simple -> El proceso padre es el que se queda corriendo
- forking -> El proceso padre lanza un proceso hijo y termina. El proceso hijo es el que se queda corriendo y es el que hay que monitorizar.
- oneshot -> El proceso padre hace su trabajo y termina (script). No se queda ningún proceso corriendo.... y no hay nada que monitorizar.
             Por ejemplo, quiero un proceso que se ejecute con el arranque del sistema, que descargue de un repositorio las nuevas versiones de unos certificados SSL... y los instale en el sistema. Eso es un proceso que se ejecuta una vez y termina.

---

# Qué es un Contenedor?

Es un entorno aislado dentro del kernel linux donde ejecutar procesos. 
Gracias a utilidades que hay en el kernel linux podemos crear entornos aislados (contenedores) donde ejecutar procesos de forma independiente del resto del sistema. Estos procesos tendrán:
- Su propio sistema de archivos (heredado de la imágenes de contenedor)
- Su propia configuración de red (IP, puertos, etc)
- Limitaciones de acceso a los recursos físicos (CPU, memoria, disco, etc)
- Sus propias variables de entorno

Hoy en día, simplemente, no tiene sentido en linux ejecutar algo fuera de un contenedor.
En algunos escenarios, son un reemplazo de las máquinas virtuales (VMs). NO SON NI PARECIDOS A LAS MÁQUINAS VIRTUALES!
Dentro de un contenedor no podemos instalar otro sistema operativo. Esa es la gran diferencia práctica con las máquinas virtuales.

## Procedimientos de instalación de software.

### Método clásico: Instalaciones a hierro

        App 1  +  App 2 +  App 3                INCONVENIENTE IMPORTANTES:
  -----------------------------------             - App1 tiene un bug (100% CPU) ----> App1 ---> OFFLINE
        Sistema Operativo ???                                                          App2 ---> OFFLINE
  -----------------------------------                                                  App3 ---> OFFLINE
                Hierro                                                                 SO   ---> OFFLINE
                                                  - Incompatibilidad entre las apps (configuraciones especiales de SO, dependencias de librerías, etc)
                                                  - Seguridad... Potencialmente una app puede tener acceso a los datos de otra app (RAM, ficheros) => VIRUS 

### Método basado en Máquinas Virtuales (VMs)

    App1      |     App 2 + App3              Me resuelve los problemas de las instalaciones a hierro... el problema
  -------------------------------------       es a qué coste?
    SO 1      |         SO 2                  INCONVENIENTE?
  -------------------------------------         - Rendimiento más bajo
    MV 1      |         MV 2                    - Merma de recursos (cada SO chupa RAM, CPU, Disco)
  -------------------------------------         - Instalación más compleja -> Mantenimiento más complejo
    Hipervisor: esXI(VMware), 
    Hyper-V (Microsoft), KVM (Linux) 
    VirtualBox (Oracle)
  -------------------------------------
        Sistema Operativo ????
  -------------------------------------
          Hierro (Hardware)

### Método basado en Contenedores

    App1        |    App2 + App3               Me resuelve los mismos problemas que me resolvía las VMs a hierro.
  -------------------------------------        con respecto a las instalaciones... pero sin sus inconvenientes.
    C1          |    C2
  -------------------------------------
    Gestor de contenedores:
    Docker, Podman, Containerd, CRIO
  -------------------------------------
     Sistema Operativo Kernel Linux
  -------------------------------------
          Hierro (Hardware)

Adoramos los contenedores. TODO SOFTWARE Empresarial hoy en día se distribuye mediante imágenes de contenedor.

Kubernetes (Openshift, Tanzu) son herramientas que nos permiten diseñar entornos de producción basados en contenedores... encargándose además de su administración/operación.

---

# Clouds

El conjunto de servicios (IT) que una empresa ofrece a sus clientes a través de internet.
Esos servicios pueden ser: SaaS, PaaS, **IaaS**.

  App1: App departamental... App de un hospital.   Esto cada vez es más raro.. aunque sigue existiendo

    Día 1:        100 usuarios
    Día 100:      100 usuarios
    Día 1000:     100 usuarios

  App2: Cualquier app que va triunfando... y cogiendo más negocio.

    Día 1:        100 usuarios
    Día 100:      10.000 usuarios             ESCALABILIDAD VERTICAL: MAS MÁQUINA! Más CPU, Más CORES
    Día 1000:     1.000.000 usuarios

  App3: Este es el día de hoy... Esto es internet.. Pero ni por días... por horas
    Día n:        100 usuarios
    Día n+1:      1.000.000 usuarios     Black friday
    Día n+2:      0 usuarios
    Día n+3:      10.000.000 usuarios    CiberMonday

  Soy la web del telepi:
    00:00  -> Usuarios = 0 (estoy cerrado)
    09:00  -> Usuarios = 0
    12:00  -> Usuarios = 10 (despistaos)
    14:00  -> Usuarios = 1.000 (la gente come y ve el telepi)
    17:30. -> Usuarios = 4 cumpleaños del cole
    20:30  -> Madrid-Barça... Usuarios = 1.000.000  ( 2 veces a la semana)... en los meses buenos
    22:30  -> Usuarios = 100 
    23:59  -> Usuarios = 0 (estoy cerrado)

  A qué me dimensiono aquí? Aquí no me vale llamar al Felipe... y que venga el jueves que viene!

    Los únicos que pueden prestar este servicio son los grandes proveedores de cloud:
    - AWS (Amazon Web Services)
    - Azure (Microsoft)
    - GCP (Google Cloud Platform)
    - IBM Cloud


  El cloud me ofrece: Infraestructura mediante un modelo de pago por uso... y sin compromisos a largo plazo.
  Además, para otro tipo de servicios, me ofrece toda la administración y mantenimiento de esos servicios (bases de datos, servidores web, balanceadores de carga, etc).... Para la infra también!
  No es solo comprar un ordenador.... es tenerlo en una habitación fresquita... anti-incendios.. con sistemas de alimentación redundantes... con conexiones a internet de alta velocidad (con varios proveedores)... con copias de seguridad automáticas... con monitorización 24x7... instalaciones...

  No es solo que me ahorre la máquina... es que me ahorro TODO lo que hay alrededor de esa máquina: Administradores de sistemas incluidos! En el cloud, todas esas operaciones están automatizadas.

---


# Alias 

En Linux existe el concepto de Alias.
Un alias es un nombre corto que representa un comando más largo o complejo.
A veces ejecutamos con frecuencia comandos con una serie de modificadores establecidos... y en lugar de escribir todo el comando completo, podemos crear un alias para ese comando.

> ps -eaf --forest 
> alias psg='ps -eaf --forest'
>
> psg


---
> Con respecto a los modificadores de los comandos en Linux (herencia POSIX), es importante saber que:

Los modificadores van precedidos de un guión (-) y pueden ser combinados juntos (sin espacios entre ellos).

- ls -l -a      =     ls -la    =     ls -al

Cuando ponemos un guión, eso significa que vamos a usar la sintaxis abreviada de los modificadores del comando.
Habitualmente, todo modificador tiene una versión larga (más descriptiva) y una versión corta (la abreviada).
La versión larga del modificador va precedida de 2 guiones (--).

- ls --long --all      =     ls --all --long

---

Tengo un megaservidor:
96 cores + 512 GB RAM 
-> Lo parcelo con máquinas virtuales (VMs)
   
   8 máquinas virtuales con 8 cores + 32 GB RAM cada una
   Y sobre ellas opero con contenedores

Antes, de una de esas máquinas físicas (servidor físico), sacaba 25 VMs.
Y hoy saco 8 ... y dentro de cada VM, puedo ejecutar 10 contenedores.

Antes si quería montar una BBDD (mariaDB), le montaba una VM exclusiva para la BBDD.
Hoy en día, tengo una máquina más ... en mi cluster de kubernetes... y ahí monto un contenedor con la BBDD... que caerá en una máquina donde haya otros 25 contenedores más de bbdd... y me vale.