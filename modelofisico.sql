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
    email_verified_at timestamp,
    password varchar(255) not null,
    remember_token varchar(100),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    check (ci REGEXP "^[0-9]{8}$")
);

create table cliente (
    id int auto_increment primary key,
    rut char(12) unique not null,
    direccion varchar(100) not null,
    email varchar(40) unique not null,
    cuentabancaria varchar(40) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    check (char_length(rut) = 12)
);

create table almacen (
    id int auto_increment primary key,
    nombre varchar(30) not null,
    tipo enum("Propio", "De terceros") default "Propio" not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp
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
    created_at timestamp default not null current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
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
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (lote_id) references lote(id),
    foreign key (almacen_id) references almacen(id),
    check (peso > 0)
);

create table ruta (
    id int auto_increment primary key,
    distanciakm decimal(6, 2) not null,
    tiempo_estimado time not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    check (distanciakm > 0)
);

create table viaje (
    id int auto_increment primary key,
    ruta_id int not null,
    salida datetime default current_timestamp not null,
    ultimo_destino datetime,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (ruta_id) references ruta(id)
);

create table vehiculo (
    id int auto_increment primary key,
    matricula char(7) unique not null,
    estado enum(
        "Disponible",
        "No disponible",
        "En reparación"
    ) default "Disponible" not null,
    peso decimal(7, 2) not null,
    limite_peso decimal(10, 2) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    check (peso > 0 and peso <= 48000),
    check (limite_peso > 0),
    check (matricula REGEXP "^[A-Z]{3}[0-9]{4}$")
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
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
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
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (vehiculo_id) references vehiculo(id),
    foreign key (lote_id) references lote(id),
    foreign key (viaje_id) references viaje(id)
);

create table transportista (
    id int auto_increment primary key,
    user_id int not null,
    vehiculo_id int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (vehiculo_id) references vehiculo(id)
);

create table funcionario (
    id int auto_increment primary key,
    user_id int not null,
    almacen_id int not null,
    empresa_id int,
    tipo enum("Propio", "De terceros") default "Propio" not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

create table administrador (
    id int auto_increment primary key,
    user_id int not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id)
);

create table telefono (
    id int auto_increment primary key,
    user_id int,
    empresa_id int,
    telefono char(9) unique not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (empresa_id) references cliente(id),
    check (telefono REGEXP "^[0-9]{1,9}$")
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
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

create table cadete (
    id int auto_increment primary key,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp
);

create table reparte_producto (
    id int auto_increment primary key,
    cadete_id int not null,
    producto_id int not null,
    fecha_salida datetime default current_timestamp not null,
    entregado tinyint(1) default 0,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp,
    foreign key (cadete_id) references cadete(id)
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
create trigger check_salida_programada
before insert on vehiculo_transporta
for each row
begin
  if NEW.salida_programada <= now() then
    signal sqlstate "45000"
    set message_text = "La fecha tiene que ser mayor a la actual";
  end if;
end;

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

    -- Obtengo el limite de peso del vehículo asignado
    select limite_peso into limite_peso_vehiculo
    from vehiculo
    where id = NEW.vehiculo_id;

    if peso_total > limite_peso_vehiculo then
    SIGNAL SQLSTATE "45000"
    set message_text = "La suma de los pesos de los lotes superan al límite del vehiculo asignado";
    end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_fecha_entrega
before insert on producto
for each row
begin
    declare fecha_actual datetime;
    declare plazo_fecha_maximo datetime;

    set fecha_actual = now();
    set plazo_fecha_maximo = DATE_ADD(fecha_actual, interval 2 day);

    if NEW.fecha_entrega < fecha_actual or NEW.fecha_entrega > plazo_fecha_maximo then
        signal sqlstate "45000"
        set message_text = "La fecha de entrega del producto es incorrecta";
    end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_salida_insertar
before insert on viaje
for each row
begin
  if NEW.salida <> now() then
    signal sqlstate "45000"
    set message_text = "La fecha tiene que ser la actual";
  end if;
end;

create trigger check_ultimo_destino_actualizar
before update on viaje
for each row
begin
  if NEW.ultimo_destino <= NEW.salida then
    signal sqlstate "45000"
    set message_text = "El último destino tiene que ser mayor a la salida";
  end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_llegada_almacen
before update on viaje_asignado
for each row
begin
  if NEW.llegada_almacen <> now() then
    signal sqlstate "45000"
    set message_text = "La fecha tiene que ser la actual";
  end if;
end;

create trigger check_salida_almacen
before update on viaje_asignado
for each row
begin
  if NEW.salida_almacen <= NEW.llegada_almacen then
    signal sqlstate "45000"
    set message_text = "La salida del tiene que ser mayor a la llegada";
  end if;
end;

create trigger check_llegada_almacen_mayor_salida
before update on viaje_asignado
for each row
begin
    declare salida_inicial datetime;

    select salida into salida_inicial
    from viaje where id = NEW.viaje_id;

    if NEW.llegada_almacen <= salida_inicial then
        signal sqlstate "45000"
        set message_text = "La llegada al almacén tiene que ser mayor a la salida inical del viaje";
    end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_existencia_ubicacion
before insert on ubicacion
for each row
begin
    if 
        NEW.user_id is null and
        NEW.almacen_id is null and
        NEW.empresa_id is null
    then
        signal sqlstate "45000"
        set message_text = "Al menos uno de user_id, almacen_id o empresa_id debe tener un valor";
        end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_existencia_telefono
before insert on telefono
for each row
begin
    if 
        NEW.user_id is null and
        NEW.empresa_id is null
    then
        signal sqlstate "45000"
        set message_text = "Al menos uno de user_id o empresa_id debe tener un valor";
    end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger check_tipo_usuario
before insert on funcionario
for each row
begin
    declare tipo_almacen varchar(15);
    declare cliente_id int;
    select tipo into tipo_almacen from almacen where id = NEW.almacen_id;

    if NEW.tipo = "Propio" and tipo_almacen <> "Propio" then
        signal sqlstate "45000"
        set message_text = 'Los funcionarios de tipo "Propio" deben tener una clave foránea con almacenes de tipo "Propio".';
    end if;

    if NEW.tipo = "De terceros" and tipo_almacen <> "De terceros" then
        signal sqlstate "45000"
        set message_text = 'Los funcionarios de tipo "De terceros" deben tener una clave foránea con almacenes de tipo "De terceros".';
    end if;

    if NEW.tipo = "De terceros" then
        select id into cliente_id from cliente where id = NEW.empresa_id;
        if cliente_id is null then
            signal sqlstate "45000"
            set message_text = 'Los funcionarios de tipo "De terceros" deben tener una clave foránea referenciando a una empresa.';
        end if;
    end if;
end;
//
DELIMITER ;