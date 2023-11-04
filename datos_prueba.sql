use santiago_etchebarne;

insert into users (ci, nombre, apellido, apellido2, email, password)
    values
        ("54345671", "Lionel", "Messi", "Cuccittini", "admin@admin.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("34345678", "Raúl", "Álvarez", "Genes", "aurongaming@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("23213678", "Guillermo", "Díaz", "Ibáñez", "madremiawilly@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789054", "Mirta", "Legrand", "Gon calvez", "mirtalegrand@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789045", "Iván", "Raúl", "Buhajeruk", "spreeen@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("34323456", "Samuel", "de Luque", "Batuecas", "v777@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789025", "Ibai", "Llanos", "Garatea", "ibaicito@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56789145", "Rubén", "Doblas", "Gundersen", "rubiuh@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56729045", "Germán", "Garmendia", "Aranís", "germengermendia@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("56783045", "Martín", "Pérez", "Disalvo", "coscu@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("54434566", "Mario", "Alonso", "Gallardo", "djmarito@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("54424566", "Alejandro", "Bravo", "Yañez", "11alexby@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("54414566", "Geronimo", "Benavidez", "Benavidez", "elmomo@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("52234566", "Javier", "Gerardo", "Milei", "libertad@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("53334566", "Daniel", "Santomé", "Lemus", "dalasreview@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y"),
        ("54573566", "Gonzálo", "Banzas", "Banzas", "gonchito@gmail.com", "$2y$10$DfhgfGk9VSPe/O///qg5iuhmT7b9o7s8.Xhrzq3LTt20c6jvocs9y");

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
        (4,5,"De terceros",1),
        (7,1,"Propio",null),
        (8,1,"Propio",null),
        (9,1,"Propio",null),
        (10,1,"Propio",null),
        (11,1,"Propio",null),
        (12,1,"Propio",null),
        (13,1,"Propio",null),
        (14,1,"Propio",null),
        (16,1,"Propio",null),
        (15,1,"Propio",null);

insert into administrador(user_id)
    values
        (1);

insert into transportista(user_id)
    values
        (5),
        (6);

insert into vehiculo (matricula,peso,limite_peso)
    values
        ("abc1234",4000,22000),
        ("abc2234",4000,22000),
        ("abc3234",4000,22000),
        ("abc4234",4000,22000);