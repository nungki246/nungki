CREATE OR REPLACE FUNCTION public.update_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	NEW.update_at = now();
    RETURN NEW;   
END;
$function$
;


CREATE TABLE public.tm_keuangan (
	id_keuangan bigserial NOT NULL,
	tanggal_transaksi timestamp not null default current_timestamp,
	keuangan varchar(50) NOT NULL DEFAULT '-'::character varying,
	debet numeric(15,2) not null default 0,
	kredit numeric(15,2) not null default 0,
	keterangan varchar(256) null,
	status_aktif int4 NOT NULL DEFAULT 1,
	create_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT tm_keuangan_pkey1 PRIMARY KEY (id_keuangan)
);
CREATE INDEX tm_keuangan_idx1 ON public.tm_keuangan USING btree (id_keuangan, tanggal_transaksi,keuangan,debet,kredit,keterangan, status_aktif);

-- Table Triggers

create trigger update_tm_keuangan before
update
    on
   public.tm_keuangan for each row execute function public.update_at();
  
  
  CREATE TABLE public.tm_agenda (
	id_agenda bigserial NOT NULL,
	tanggal_agenda_mulai timestamp not null default current_timestamp,
	tanggal_agenda_selesai timestamp not null default current_timestamp,
	agenda varchar(50) NOT NULL DEFAULT '-'::character varying,
	total_pengeluaran numeric(10,2) not null default 0,
	keterangan varchar(256) null,
	status_aktif int4 NOT NULL DEFAULT 1,
	create_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT tm_agenda_pkey1 PRIMARY KEY (id_agenda)
);
CREATE INDEX tm_agenda_idx1 ON public.tm_agenda USING btree (id_agenda, tanggal_agenda_mulai,tanggal_agenda_selesai,agenda,total_pengeluaran,keterangan, status_aktif);

-- Table Triggers

create trigger update_tm_agenda before
update
    on
   public.tm_agenda for each row execute function public.update_at();
    

  CREATE TABLE public.tm_agenda_detail (
    id_agenda_detail bigserial NOT null,
	id_agenda bigint NOT null default 0,
	tanggal_agenda_detail timestamp not null default current_timestamp,
	agenda_detail varchar(512) NOT NULL DEFAULT '-'::character varying,
	jumlah_pengeluaran numeric(10,2) not null default 0,
	keterangan varchar(256) null,
	status_aktif int4 NOT NULL DEFAULT 1,
	create_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT tm_agenda_detail_pkey1 PRIMARY KEY (id_agenda_detail),
	CONSTRAINT tm_agenda_detail_fkey1 foreign key (id_agenda) REFERENCES public.tm_agenda (id_agenda)
);
CREATE INDEX tm_agenda_detail_idx1 ON public.tm_agenda_detail USING btree (id_agenda_detail, tanggal_agenda_detail,agenda_detail,jumlah_pengeluaran,keterangan, status_aktif);

-- Table Triggers

create trigger update_tm_agenda_detail before
update
    on
   public.tm_agenda_detail for each row execute function public.update_at();


