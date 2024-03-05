-- Group [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user" (
   "oid"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
  primary key ("oid")
);


-- Apuntes [ent1]
create table "public"."apuntes" (
   "oid"  int4  not null,
   "titulo"  varchar(255),
   "texto"  varchar(255),
  primary key ("oid")
);


-- Discusiones [ent2]
create table "public"."discusiones" (
   "oid"  int4  not null,
   "titulo"  varchar(255),
  primary key ("oid")
);


-- Mensajes_Discusion [ent3]
create table "public"."mensajes_discusion" (
   "oid"  int4  not null,
   "texto"  varchar(255),
  primary key ("oid")
);


-- Asignatura [ent4]
create table "public"."asignatura" (
   "oid"  int4  not null,
  primary key ("oid")
);


-- Conversaciones [ent5]
create table "public"."conversaciones" (
   "oid"  int4  not null,
   "emisor"  int4,
   "receptor"  int4,
  primary key ("oid")
);


-- Mensajes_Conver [ent6]
create table "public"."mensajes_conver" (
   "oid"  int4  not null,
   "texto"  varchar(255),
   "username"  varchar(255),
  primary key ("oid")
);


-- Valoracion [ent7]
create table "public"."valoracion" (
   "oid"  int4  not null,
   "valoracion"  int4,
   "comentario"  varchar(255),
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;
alter table "public"."group"   add constraint fk_group_module foreign key ("module_oid") references "public"."module" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("group_oid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("module_oid") references "public"."module" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group foreign key ("group_oid") references "public"."group" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("group_oid") references "public"."group" ("oid");


-- Descargar [rel1]
create table "public"."descargar" (
   "user_oid"  int4 not null,
   "apuntes_oid"  int4 not null,
  primary key ("user_oid", "apuntes_oid")
);
alter table "public"."descargar"   add constraint fk_descargar_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."descargar"   add constraint fk_descargar_apuntes foreign key ("apuntes_oid") references "public"."apuntes" ("oid");


-- Apuntes_Valoracion [rel12]
alter table "public"."valoracion"  add column  "oid"  int4;
alter table "public"."valoracion"   add constraint fk_valoracion_apuntes foreign key ("oid") references "public"."apuntes" ("oid");


-- Valorar [rel14]
alter table "public"."valoracion"  add column  "oid"  int4;
alter table "public"."valoracion"   add constraint fk_valoracion_user foreign key ("oid") references "public"."user" ("oid");


-- Suscribirse_Asignatura [rel15]
create table "public"."suscribirse_asignatura" (
   "user_oid"  int4 not null,
   "asignatura_oid"  int4 not null,
  primary key ("user_oid", "asignatura_oid")
);
alter table "public"."suscribirse_asignatura"   add constraint fk_suscribirse_asignatura_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."suscribirse_asignatura"   add constraint fk_suscribirse_asignatura_asig foreign key ("asignatura_oid") references "public"."asignatura" ("oid");


-- Mensajes_Conver [rel16]
alter table "public"."mensajes_conver"  add column  "oid"  int4;
alter table "public"."mensajes_conver"   add constraint fk_mensajes_conver_conversacio foreign key ("oid") references "public"."conversaciones" ("oid");


-- Usuario_Mensajes_Conver [rel17]
alter table "public"."mensajes_conver"  add column  "user_oid"  int4;
alter table "public"."mensajes_conver"   add constraint fk_mensajes_conver_user foreign key ("user_oid") references "public"."user" ("oid");


-- TemaDiscusion [rel18]
alter table "public"."discusiones"  add column  "asignatura_oid"  int4;
alter table "public"."discusiones"   add constraint fk_discusiones_asignatura foreign key ("asignatura_oid") references "public"."asignatura" ("oid");


-- User_Conversaciones [rel19]
create table "public"."user_conversaciones" (
   "user_oid"  int4 not null,
   "conversaciones_oid"  int4 not null,
  primary key ("user_oid", "conversaciones_oid")
);
alter table "public"."user_conversaciones"   add constraint fk_user_conversaciones_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_conversaciones"   add constraint fk_user_conversaciones_convers foreign key ("conversaciones_oid") references "public"."conversaciones" ("oid");


-- Subir [rel2]
alter table "public"."apuntes"  add column  "oid"  int4;
alter table "public"."apuntes"   add constraint fk_apuntes_user foreign key ("oid") references "public"."user" ("oid");


-- MensajesDeDiscusion [rel3]
alter table "public"."mensajes_discusion"  add column  "oid"  int4;
alter table "public"."mensajes_discusion"   add constraint fk_mensajes_discusion_discusio foreign key ("oid") references "public"."discusiones" ("oid");


-- CrearDiscusion [rel4]
alter table "public"."discusiones"  add column  "oid"  int4;
alter table "public"."discusiones"   add constraint fk_discusiones_user foreign key ("oid") references "public"."user" ("oid");


-- UsuarioMensajesDiscusion [rel5]
alter table "public"."mensajes_discusion"  add column  "oid"  int4;
alter table "public"."mensajes_discusion"   add constraint fk_mensajes_discusion_user foreign key ("oid") references "public"."user" ("oid");


-- CrearAsignatura [rel6]
alter table "public"."asignatura"  add column  "oid"  int4;
alter table "public"."asignatura"   add constraint fk_asignatura_user foreign key ("oid") references "public"."user" ("oid");


-- AsignaturaDeApuntes [rel7]
alter table "public"."apuntes"  add column  "oid"  int4;
alter table "public"."apuntes"   add constraint fk_apuntes_asignatura foreign key ("oid") references "public"."asignatura" ("oid");


