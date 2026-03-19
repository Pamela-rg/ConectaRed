incluye un script interactivo llamado conectaRed.sh, para gestionar conexiones de red en Linux de manera sencilla y segura desde la terminal. Permite ver interfaces, cambiar su estado, conectarse a redes cableadas o inalámbricas, y configurar direcciones IP de manera dinámica o estática, todo con un menú intuitivo.

Funcionalidades principales

Mostrar interfaces: Lista todas las interfaces de red disponibles y su estado actual.

Cambiar estado de interfaz: Permite levantar (up) o bajar (down) cualquier interfaz de red.

Conectar a una red:

Detecta si la interfaz es Wi-Fi o Ethernet.

En Wi-Fi, escanea redes disponibles, muestra la lista y permite ingresar SSID y contraseña.

Permite configurar la IP como dinámica (DHCP) o estática, según lo que el usuario elija.

Configurar IP directamente: Configura IP estática o dinámica en cualquier interfaz sin necesidad de conectarse primero.

Guardar cambios permanentemente: Recarga las configuraciones de NetworkManager para que las modificaciones persistan.

Uso

El script es interactivo, por lo que no necesita pasar argumentos como parámetros, todo se hace desde el menú.

Ejecución
sudo ./conectaRed.sh

Nota: Se requiere ejecutar como root o usando sudo para poder modificar interfaces de red.

Menú de opciones

Al ejecutar el script, aparecerá un menú como este:

1. Ver_interfaces
2. Cambiar_estado
3. Conectar_Red
4. Configurar_IP
5. Guardar_Permanente
6. Salir

Solo debes seleccionar una opción ingresando el número correspondiente y seguir las indicaciones que aparecerán en pantalla.

Buenas prácticas implementadas

Verificación de permisos: El script comprueba que se ejecute como root para evitar errores.

Menú interactivo: Facilita la administración de redes sin memorizar comandos complejos.

Validación de entradas: Verifica nombres de interfaz y tipo de conexión antes de ejecutar comandos.

Uso de nmcli e ip: Comandos nativos de Linux para gestión de interfaces y redes.

Soporte de múltiples tipos de red: Funciona tanto con Wi-Fi como Ethernet.

Feedback en consola: Mensajes claros sobre el estado de cada operación y confirmaciones de éxito o error.# ConectaRed
