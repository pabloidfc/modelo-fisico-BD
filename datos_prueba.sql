use santiago_etchebarne;

insert into users (ci, nombre, apellido, apellido2, email, password)
    values
        ("54345671", "Pablo", "King", "Kong", "admin@admin.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("34345678", "Federico", "King", "Kong", "ferkinkong@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("23213678", "Alberto", "Fernandez", "Fernandez", "alferfer@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789054", "Mirta", "Legrand", "Gon calvez", "mirtalegrand@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789045", "Enirique", "Cleptomano", "Sole", "eniruqe@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("54434566", "Milei", "Milanga", "Milanguesa", "2020jajasalu2@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y");

insert into cliente(rut,direccion,email,cuentabancaria)
    values
        ("123456789102", "Larravide", "jaja@gmail.com", "6565654321092");

insert into almacen (nombre, tipo)
    values
        ("Almacen Montevideo", "Propio"),
        ("Almacen Salto", "Propio"),
        ("Almacen Durázno", "Propio"),
        ("Almacen Tacuárembo", "Propio"),
        ("Crecom", "De terceros");

insert into ubicacion (user_id, calle, nro_de_puerta, departamento)
    values
        (1, "Larravide", 11, "Montevideo"),
        (2, "Larravide", 22, "Montevideo"),
        (3, "Larravide", 13, "Montevideo"),
        (4, "Larravide", 101, "Montevideo");

insert into ubicacion (almacen_id, calle, nro_de_puerta, departamento) 
    values 
        (1, "Ruta 101", 3, "Montevideo"),
        (2, "Florinda", 3, "Salto"), 
        (3, "Ordoñez", 55, "Durázno"),
        (4, "Horacio", 78, "Tacuárembo");

insert into telefono (user_id, telefono)
    values  
        (1, "096420645"),
        (2, "096420644"),
        (3, "096420633"),
        (4, "096420622");

insert into funcionario(user_id,almacen_id,tipo,empresa_id)
    values
        (2,1,"Propio",null),
        (3,1,"Propio",null),
        (4,5,"De terceros",1);

insert into administrador(user_id)
    values
        (1);

insert into transportista(user_id)
    values
        (5),
        (6);