drop database if exists santiago_etchebarne;
create database santiago_etchebarne;
use santiago_etchebarne;

create table users (
    id int auto_increment primary key,
    ci char(8) unique not null,
    nombre varchar(15) not null,
    nombre2 varchar(15),
    apellido varchar(15) not null,
    apellido2 varchar(15) not null,
    email varchar(40) unique not null,
    password varchar(255) not null
);

create table cliente (
    id int auto_increment primary key,
    rut char(12) not null,
    direccion varchar(100) not null,
    email varchar(40) not null,
    cuentabancaria varchar(40) not null
);

create table almacen (
    id int auto_increment primary key,
    nombre varchar(30) not null,
    tipo enum("Propio", "De terceros") not null
);

create table lote (
    id int auto_increment primary key,
    creador_id int not null,
    almacen_destino int not null,
    estado enum(
        "Creado",
        "En viaje",
        "Desarmado"
    ) default "Creado" not null,
    peso decimal(10, 2) not null,
    created_at timestamp not null default current_timestamp,
    foreign key (creador_id) references users(id),
    foreign key (almacen_destino) references almacen(id),
    check (peso > 0)
);

create table producto (
    id int auto_increment primary key,
    lote_id int,
    almacen_id int not null,
    peso decimal(10, 2) not null,
    estado enum(
        "En espera",
        "Almacenado",
        "Loteado",
        "En ruta",
        "Desloteado",
        "En viaje",
        "Entregado"
    ) default "En espera" not null,
    departamento enum(
        "Artigas",
        "Canelones",
        "Cerro Largo",
        "Colonia",
        "Durazno",
        "Flores",
        "Florida",
        "Lavalleja",
        "Maldonado",
        "Montevideo",
        "Paysandú",
        "Río Negro",
        "Rivera",
        "Rocha",
        "Salto",
        "San José",
        "Soriano",
        "Tacuarembó",
        "Treinta y Tres"
    ) not null,
    direccion_entrega varchar(100) not null,
    fecha_entrega date not null,
    foreign key (lote_id) references lote(id),
    foreign key (almacen_id) references almacen(id)
);

create table ruta (
    id int auto_increment primary key,
    distanciakm decimal(6, 2) not null,
    tiempo_estimado time not null,
    check (distanciakm > 0)
);

create table viaje (
    id int auto_increment primary key,
    ruta_id int not null,
    salida datetime,
    ultimo_destino datetime,
    foreign key (ruta_id) references ruta(id)
);

create table vehiculo (
    id int auto_increment primary key,
    matricula varchar(7) unique not null,
    estado enum(
        "Disponible",
        "No disponible",
        "En reparación"
    ) default "Disponible" not null,
    peso decimal(7, 2) not null,
    limite_peso decimal(10, 2) not null,
    check (peso > 0 and peso <= 48000),
    check (limite_peso > 0)
);

create table vehiculo_transporta (
    id int auto_increment primary key,
    vehiculo_id int not null,
    lote_id int not null,
    orden tinyint not null,
    estado_viaje enum(
        "No iniciado",
        "En curso",
        "Finalizado"
    ) default "No iniciado" not null,
    salida_programada datetime not null,
    foreign key (vehiculo_id) references vehiculo(id),
    foreign key (lote_id) references lote(id),
    check (orden > 0)
);

create table viaje_asignado (
    id int auto_increment primary key,
    vehiculo_id int not null,
    lote_id int not null,
    viaje_id int not null,
    llegada_almacen datetime,
    salida_almacen datetime,
    foreign key (vehiculo_id) references vehiculo(id),
    foreign key (lote_id) references lote(id),
    foreign key (viaje_id) references viaje(id)
); 

create table transportista (
    id int auto_increment primary key,
    user_id int not null,
    vehiculo_id int,
    foreign key (user_id) references users(id),
    foreign key (vehiculo_id) references vehiculo(id)
);

create table funcionario (
    id int auto_increment primary key,
    user_id int not null,
    almacen_id int not null,
    empresa_id int,
    tipo enum("Propio", "De terceros") not null,
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

create table administrador (
    id int auto_increment primary key,
    user_id int not null,
    foreign key (user_id) references users(id)
);

create table telefono (
    id int auto_increment primary key,
    user_id int,
    empresa_id int,
    telefono char(9),
    foreign key (user_id) references users(id),
    foreign key (empresa_id) references cliente(id)
);

create table ubicacion (
    id int auto_increment primary key,
    user_id int,
    almacen_id int,
    empresa_id int,
    calle varchar(30) not null,
    esquina varchar(30),
    nro_de_puerta int not null,
    departamento enum(
        "Artigas",
        "Canelones",
        "Cerro Largo",
        "Colonia",
        "Durazno",
        "Flores",
        "Florida",
        "Lavalleja",
        "Maldonado",
        "Montevideo",
        "Paysandú",
        "Río Negro",
        "Rivera",
        "Rocha",
        "Salto",
        "San José",
        "Soriano",
        "Tacuarembó",
        "Treinta y Tres"
    ) not null,
    coordenada varchar(255),
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

DELIMITER //
create trigger check_sum_peso_productos
after insert on lote
for each row
begin
    declare lote_peso decimal(10,2);
    declare suma_peso_productos decimal(10,2);

    select NEW.peso into lote_peso;

    select sum(peso) into suma_peso_productos
    from producto
    where lote_id = NEW.id;

    if lote_peso <> suma_peso_productos then
        signal sqlstate "45000"
        set message_text = "La suma de los pesos de los productos no coincide con el peso del lote";
        delete from lote where id = NEW.id;
    end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_vehiculo_transporta_salida_programada
before insert on vehiculo_transporta
for each row
begin
  if NEW.salida_programada <= now() then
    signal sqlstate "45000"
    set message_text = "La fecha tiene que ser mayor a la actual";
  end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_limite_peso_vehiculo
before insert on vehiculo_transporta
for each row
begin
    declare peso_total decimal(10, 2);
    declare peso_anteriores_lotes decimal(10, 2);
    declare peso_nuevo_lote decimal(10, 2);
    declare limite_peso_vehiculo decimal(10, 2);

    -- Obtengo el peso de los Anteriores Lotes
    select sum(l.peso) into peso_anteriores_lotes
    from lote l
    where id in (
        select lote_id from vehiculo_transporta vt
        where vehiculo_id = NEW.vehiculo_id and estado_viaje = NEW.estado_viaje
    );

    -- Obtengo el peso del Lote actual
    select peso into peso_nuevo_lote
    from lote where id = NEW.lote_id;

    -- Sumo los pesos
    set peso_total = peso_anteriores_lotes + peso_nuevo_lote;

    -- COMMENT
    select limite_peso into limite_peso_vehiculo
    from vehiculo
    where id = NEW.vehiculo_id;

    if peso_total > limite_peso_vehiculo then
    SIGNAL SQLSTATE "45000"
    set message_text = "La suma de los pesos de los lotes superan al límite del vehiculo asignado";
    end if;
END;
//
DELIMITER ;