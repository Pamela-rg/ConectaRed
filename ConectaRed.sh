#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Ejecuta el script como root o con sudo"
    exit 1
fi

ver_interfaces() {
    ip -brief a show  
}

cambiar_estado() {
    ver_interfaces
    read -p "Nombre de la interfaz (ej. eth0, wlan0): " iface
    read -p "Levantar (up) o bajar (down)?: " estado
    ip link set dev "$iface" "$estado"  # cambiar estado de interfaz
    echo "Estado de $iface cambiado a $estado"
}

configurar_ip() {
    read -p "Tipo de IP [estatica/dinamica]: " tipo_ip
    read -p "Interfaz a configurar: " iface

    if [[ "$tipo_ip" == "estatica" ]]; then
        read -p "IP con prefijo (ej. 192.168.1.50/24): " ip_addr
        read -p "Puerta de enlace (gateway): " gateway
        read -p "DNS (separados por comas): " dns

        nmcli connection add type ethernet ifname "$iface" con-name "${iface}-estatica" ipv4.method manual ipv4.addresses "$ip_addr" ipv4.gateway "$gateway" ipv4.dns "$dns"  # agregar conexión estática
        nmcli connection up "${iface}-estatica"  # activar conexión
        echo "IP estática aplicada y guardada"
    else
        dhclient "$iface"  # DHCP -> ip dinámica
        echo "IP dinámica aplicada"
    fi
}

conectar_red() {
    ver_interfaces
    read -p "Interfaz a usar: " iface
    tipo=$(nmcli -t -f TYPE dev show "$iface" | head -n1)  # obtener tipo de interfaz

    if [[ "$tipo" == "wifi" ]]; then
        ip link set dev "$iface" up  # levantar interfaz wifi
        nmcli device wifi rescan ifname "$iface"  # escanear redes
        nmcli device wifi list ifname "$iface"  # mostrar redes
        read -p "SSID de la red: " ssid
        read -sp "Contraseña (deja vacío si abierta): " pass
        echo ""
        nmcli device wifi connect "$ssid" password "$pass" ifname "$iface"  # conectar wifi
        configurar_ip  # configurar IP estática/dinámica después
        
    elif [[ "$tipo" == "ethernet" ]]; then
        ip link set dev "$iface" up  # levantar cableada
        configurar_ip  # configurar ip
        
    else
        echo "Tipo de interfaz no soportado"
    fi
}

guardar_permanente() {
    nmcli connection reload  # recarga configuraciones permanentes de networkManager
    echo "Cambios guardados permanentemente"
}

# menu
OPTIONS="Ver_interfaces Cambiar_estado Conectar_Red Configurar_IP Guardar_Permanente Salir"

select opt in $OPTIONS; do
    case $opt in
        Ver_interfaces) ver_interfaces ;;
        
        Cambiar_estado) cambiar_estado ;;
        
        Conectar_Red) conectar_red ;;
        
        Configurar_IP) configurar_ip ;;
        
        Guardar_Permanente) guardar_permanente ;;
        
        Salir) echo "Saliendo..."; exit 0 ;;
        
        *) echo "Opción inválida" ;;
    esac
done
