drop database if exists project;
create database project;
use project;

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
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp
);

create table cliente (
    id int auto_increment primary key,
    rut char(12) not null,
    direccion varchar(100) not null,
    email varchar(40) not null,
    cuentabancaria varchar(40) not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp
);

create table almacen (
    id int auto_increment primary key,
    nombre varchar(30) not null,
    tipo enum("Propio", "De terceros") not null,
    created_at timestamp not null,
    updated_at timestamp,
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
    peso float not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (creador_id) references users(id),
    foreign key (almacen_destino) references almacen(id)
);

create table producto (
    id int auto_increment primary key,
    lote_id int,
    almacen_id int,
    peso float not null,
    estado enum(
        "En espera",
        "Almacenado",
        "Loteado",
        "Desloteado",
        "En viaje",
        "Entregado"
    ) default "En espera" not null,
    departamento varchar(15) not null,
    direccion_entrega varchar(100) not null,
    fecha_entrega date not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (lote_id) references lote(id),
    foreign key (almacen_id) references almacen(id)
);

create table ruta (
    id int auto_increment primary key,
    distanciakm float not null,
    tiempo_estimado time not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp
);

create table viaje (
    id int auto_increment primary key,
    ruta_id int not null,
    salida datetime,
    ultimo_destino datetime,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (ruta_id) references ruta(id)
);

create table vehiculo (
    id int auto_increment primary key,
    matricula char(10) not null,
    estado enum (
        "Disponible",
        "No disponible",
        "En reparación"
    ) default "Disponible" not null,
    peso float not null,
    limite_peso float,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp
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
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (vehiculo_id) references vehiculo(id),
    foreign key (lote_id) references lote(id)
);

create table viaje_asignado (
    id int auto_increment primary key,
    vehiculo_id int not null,
    lote_id int not null,
    viaje_id int not null,
    llegada_almacen datetime,
    salida_almacen datetime,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (vehiculo_id) references vehiculo(id),
    foreign key (lote_id) references lote(id),
    foreign key (viaje_id) references viaje(id)
); 

create table transportista (
    id int auto_increment primary key,
    user_id int not null,
    vehiculo_id int,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (vehiculo_id) references vehiculo(id)
);

create table funcionario (
    id int auto_increment primary key,
    user_id int not null,
    almacen_id int not null,
    empresa_id int,
    tipo enum("Propio", "De terceros") not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

create table administrador (
    id int auto_increment primary key,
    user_id int not null,
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id)
);

create table telefono (
    id int auto_increment primary key,
    user_id int,
    empresa_id int,
    telefono char(9),
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
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
    departamento varchar(15),
    coordenada varchar(255),
    created_at timestamp not null,
    updated_at timestamp,
    deleted_at timestamp,
    foreign key (user_id) references users(id),
    foreign key (almacen_id) references almacen(id),
    foreign key (empresa_id) references cliente(id)
);

insert into users (ci, nombre, apellido, apellido2, email, password, created_at,updated_at)
    values
        ("54345670", "Guillermo", "Texeira", "Gon calvez", "admin@admin.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y", now(), now()),
        ("53213450", "Eustaquio", "Abichuelas", "Fernandez", "@eu.abichuelas@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y", now(), now()),
        ("52345670", "Fernando", "Fernandez", "Fernandez", "ferferfer@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y", now(), now()),
        ("51245670", "Rodrigo", "Rodriguez", "Rodriguez", "rodrodrod@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y", now(), now());

insert into almacen (nombre, tipo, created_at, updated_at)
    values
        ("Almacen Montevideo", "Propio", now(), now()),
        ("Almacen Salto", "Propio", now(), now()),
        ("Almacen Durázno", "Propio", now(), now()),
        ("Almacen Tacuárembo", "Propio", now(), now());

insert into ubicacion (user_id, calle, nro_de_puerta, departamento, created_at, updated_at)
    values
        (1, "Larravide", 11, "Montevideo", now(), now()),
        (2, "Larravide", 22, "Montevideo", now(), now()),
        (3, "Larravide", 13, "Montevideo", now(), now()),
        (4, "Larravide", 101, "Montevideo", now(), now());

insert into ubicacion (almacen_id, calle, nro_de_puerta, departamento, created_at, updated_at)
    values
        (1, "Ruta 101", 3, "Montevideo", now(), now()),
        (2, "Florinda", 3, "Salto", now(), now()),
        (3, "Ordoñez", 55, "Durázno", now(), now()),
        (4, "Horacio", 78, "Tacuárembo", now(), now());



insert into telefono (user_id, telefono, created_at, updated_at)
    values  
        (1, "096420645", now(), now()),
        (2, "096420644", now(), now()),
        (3, "096420633", now(), now()),
        (4, "096420622", now(), now());

insert into producto (almacen_id, peso, departamento, direccion_entrega, fecha_entrega, created_at, updated_at)
    values
        (1, 44.2, "Salto", "Horacio 22", "2023-10-5", now(), now()),
        (1, 2.1, "Salto", "Horacio 22", "2023-10-5", now(), now()),
        (1, 13.22, "Salto", "Horacio 22", "2023-10-5", now(), now());

insert into vehiculo (matricula, peso, limite_peso, created_at, updated_at)
    values
        ("34567GHDS2", 1000, 500, now(), now()),
        ("345F7GHDS2", 1000, 500, now(), now());

insert into ruta (distanciakm, tiempo_estimado, created_at, updated_at)
    values
        (1000, "04:43:00", now(), now());

insert into administrador (user_id, created_at, updated_at)
    values
        (1, now(), now());

insert into funcionario (user_id, almacen_id, tipo,created_at, updated_at)
    values
      (2, 1, "Propio", now(), now());

insert into transportista (user_id,created_at, updated_at)
    values
        (3, now(), now());