/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     22/11/2020 22:16:48                          */
/*==============================================================*/


drop table DRON;

drop table DRON_HORA;

drop table HORA;

drop table SISTEMA;

/*==============================================================*/
/* Table: DRON                                                  */
/*==============================================================*/
create table DRON (
   DRON_ID              VARCHAR(4)           not null,
   SISTEMA_ID           VARCHAR(4)           null,
   DRON_NOMBRE          VARCHAR(30)          null,
   constraint PK_DRON primary key (DRON_ID)
);

/*==============================================================*/
/* Table: DRON_HORA                                             */
/*==============================================================*/
create table DRON_HORA (
   DRON_ID              VARCHAR(4)           not null,
   HORA_ID              VARCHAR(4)           not null,
   constraint PK_DRON_HORA primary key (DRON_ID, HORA_ID)
);

/*==============================================================*/
/* Table: HORA                                                  */
/*==============================================================*/
create table HORA (
   HORA_ID              VARCHAR(4)           not null,
   HORA_INICIO          TIME                 null,
   HORA_FIN             TIME                 null,
   constraint PK_HORA primary key (HORA_ID)
);

/*==============================================================*/
/* Table: SISTEMA                                               */
/*==============================================================*/
create table SISTEMA (
   SISTEMA_ID           VARCHAR(4)           not null,
   SISTEMA_NOMBRE       VARCHAR(10)          null,
   constraint PK_SISTEMA primary key (SISTEMA_ID)
);

alter table DRON
   add constraint FK_DRON_SISTEMA_D_SISTEMA foreign key (SISTEMA_ID)
      references SISTEMA (SISTEMA_ID)
      on delete restrict on update restrict;

alter table DRON_HORA
   add constraint FK_DRON_HOR_DRON_HORA_DRON foreign key (DRON_ID)
      references DRON (DRON_ID)
      on delete restrict on update restrict;

alter table DRON_HORA
   add constraint FK_DRON_HOR_DRON_HORA_HORA foreign key (HORA_ID)
      references HORA (HORA_ID)
      on delete restrict on update restrict;

