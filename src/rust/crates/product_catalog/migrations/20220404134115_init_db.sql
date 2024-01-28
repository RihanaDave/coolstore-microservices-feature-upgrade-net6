-- Add migration script here

-- Add up migration script here

START TRANSACTION;

CREATE SCHEMA IF NOT EXISTS catalog;

-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE catalog.categories (
    -- id uuid NOT NULL DEFAULT (uuid_generate_v4()),
    id uuid NOT NULL DEFAULT (md5(random()::text || clock_timestamp()::text)::uuid),
    name text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NULL,
    CONSTRAINT pk_categories PRIMARY KEY (id)
);

CREATE TABLE catalog.products (
    -- id uuid NOT NULL DEFAULT (uuid_generate_v4()),
    id uuid NOT NULL DEFAULT (md5(random()::text || clock_timestamp()::text)::uuid),
    name text NOT NULL,
    description text NOT NULL,
    price double precision NOT NULL,
    image_url text NOT NULL,
    inventory_id uuid NOT NULL,
    category_id uuid NOT NULL,
    is_deleted boolean NOT NULL,
    created timestamp without time zone NOT NULL DEFAULT (now()),
    updated timestamp without time zone NULL,
    CONSTRAINT pk_products PRIMARY KEY (id),
    CONSTRAINT fk_products_categories_category_id FOREIGN KEY (category_id) REFERENCES catalog.categories (id) ON DELETE CASCADE
);

CREATE INDEX ix_products_category_id ON catalog.products (category_id);

CREATE UNIQUE INDEX ix_products_id ON catalog.products (id);

COMMIT;


START TRANSACTION;

INSERT INTO catalog.categories (id,name,created,updated) VALUES
('77666AA8-682C-4047-B075-04839281630A','Beverage products','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319')
,('1EBDD04F-A447-42A3-9E65-5697C1DACB09','Accessories','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319')
,('664690EE-A647-4B12-B87F-AF5C511187EB','Food products','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319')
,('80287EF3-987F-4312-A0C6-CCC2239AEEA3','Electronic Gadgets','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319')
;

INSERT INTO catalog.products (id,created,updated,name,description,price,image_url,inventory_id,is_deleted,category_id) VALUES
('6B8D0110-E3E8-4727-A51E-06F38864E464','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319','Ice Cream Bar - Oreo Cone','Proximal gastrectomy',2236,'https://picsum.photos/1200/900?image=21','B8B62196-6369-409D-B709-11C112DD023F','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('FEE1FC67-7469-4490-B418-47F4732DE53F','2003-09-27 23:38:43.044','2010-09-18 14:00:34.626','Bag - Regular Kraft 20 Lb','Open periph nerve biopsy',2147,'https://picsum.photos/1200/900?image=7','B8B62196-6369-409D-B709-11C112DD023F','FALSE','1EBDD04F-A447-42A3-9E65-5697C1DACB09')
,('297C5959-4808-4F40-8D6A-4A899505E1F7','1989-07-28 11:42:10.666','1988-01-15 21:24:41.896','Oranges - Navel, 72','Remove bladder stimulat',1731,'https://picsum.photos/1200/900?image=10','B8B62196-6369-409D-B709-11C112DD023F','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('FAC2CCC6-2C3F-4C1E-ACBD-5354BA0873FB','1994-05-12 21:36:07.716','2017-08-31 05:34:12.297','Pasta - Cappellini, Dry','Plastic rep ext ear NEC',3305,'https://picsum.photos/1200/900?image=19','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('4693520A-2B14-4D90-8B64-541575511382','1990-01-19 01:22:33.299','2017-12-13 17:22:41.009','Prunes - Pitted','Abdomen wall repair NEC',1191,'https://picsum.photos/1200/900?image=27','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('CFC5CFF8-AB2A-4C70-994D-5AB8CCB7CB0D','1990-01-19 01:22:33.299','2017-12-13 17:22:41.009','Crab - Dungeness, Whole, live','Chng hnd mus/ten lng NEC',1665,'https://picsum.photos/1200/900?image=18','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('BA16DA71-C7DD-4EAC-9EAD-5C2C2244E69F','1991-08-02 15:33:00.040','2008-03-09 03:05:15.522','IPhone 8','IPhone 8',900,'https://picsum.photos/1200/900?image=1','90C9479E-A11C-4D6D-AAAA-0405B6C0EFCD','FALSE','80287EF3-987F-4312-A0C6-CCC2239AEEA3')
,('13D02035-2286-4055-AD2D-6855A60EFBBB','2016-05-10 05:01:44.437','2008-09-12 15:10:31.142','IPhone X','IPhone X',1000,'https://picsum.photos/1200/900?image=2','90C9479E-A11C-4D6D-AAAA-0405B6C0EFCD','FALSE','80287EF3-987F-4312-A0C6-CCC2239AEEA3')
,('97AD5BF4-D153-41C5-A6E0-6D0BFBBB4F67','1992-07-03 17:49:58.096','1998-02-09 13:10:05.477','Oil - Olive','Skull plate removal',1124,'https://picsum.photos/1200/900?image=17','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('2D2245E4-213A-49DE-93D3-79E9439400F5','2011-03-19 15:43:25.445','1995-04-01 09:47:41.323','Wonton Wrappers','Tibia/fibula inj op NOS',2200,'https://picsum.photos/1200/900?image=8','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
;
INSERT INTO catalog.products (id,created,updated,name,description,price,image_url,inventory_id,is_deleted,category_id) VALUES
('B243A35D-120A-4DB3-AD12-7B3FA80E6391','1985-01-29 08:40:58.052','1993-09-06 02:01:38.318','Soup - Campbells Chili','Implt/repl carddefib tot',3294,'https://picsum.photos/1200/900?image=25','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('6E3AC253-517D-48E5-96AD-800451F8591C','1992-07-03 17:49:58.096','1998-02-09 13:10:05.477','Longos - Penne With Pesto','Wound catheter irrigat',3639,'https://picsum.photos/1200/900?image=26','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('71C46659-9560-4D6A-AC18-893477ED6662','2011-08-21 09:27:19.085','1993-05-12 19:58:14.319','Lettuce - Boston Bib','Oth thorac op thymus NOS',3453,'https://picsum.photos/1200/900?image=12','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('E88E07F8-358D-48F7-B17C-8A16458F9C0A','1993-07-19 18:00:12.268','1988-08-26 10:59:03.959','Lotus Leaves','Oth chest cage rep/plast',1504,'https://picsum.photos/1200/900?image=24','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('F92BFA6A-2522-4234-A7F1-9004596A4A85','1984-09-29 12:43:40.750','1995-05-22 15:23:36.230','Godiva White Chocolate','Toxicology-endocrine',2067,'https://picsum.photos/1200/900?image=13','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('3B69E116-9DD6-400F-96CE-9911F4F6AC8B','1984-09-29 12:43:40.750','1995-05-22 15:23:36.230','Mix - Cocktail Ice Cream','Appendiceal ops NEC',232,'https://picsum.photos/1200/900?image=22','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('22112BB2-C324-4860-8EB9-9C78853A52A5','1985-01-29 08:40:58.052','1993-09-06 02:01:38.318','Beef - Tenderloin Tails','Vessel operation NEC',967,'https://picsum.photos/1200/900?image=16','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('6A0E6D20-8BCC-450F-BC5C-B8F727083DCD','2016-12-13 01:54:58.027','2017-01-08 15:29:22.082','Bread - White, Unsliced','Fiber-optic bronchoscopy',2809,'https://picsum.photos/1200/900?image=6','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('1ADBC55A-4354-4205-B96D-C95E2DC806F4','2007-09-05 15:16:07.726','1992-02-25 23:43:45.169','Milk - Skim','Interat ven retrn transp',3310,'https://picsum.photos/1200/900?image=20','B8B62196-6369-409D-B709-11C112DD023F','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('C3770B10-DD0F-4B1C-83AA-D424C175C087','1980-02-20 19:44:23.924','1981-02-17 03:20:56.856','Beef - Shank','Hepatic lobectomy',3196,'https://picsum.photos/1200/900?image=20','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
;
INSERT INTO catalog.products (id,created,updated,name,description,price,image_url,inventory_id,is_deleted,category_id) VALUES
('FFD60654-1802-48BD-B4C3-D49831A8AB2C','1999-01-25 00:11:04.022','2006-12-03 03:01:37.382','Asus UX370U i7 8550U (C4217TS)','Asus UX370U i7 8550U (C4217TS)',500,'https://picsum.photos/1200/900?image=4','90C9479E-A11C-4D6D-AAAA-0405B6C0EFCD','FALSE','80287EF3-987F-4312-A0C6-CCC2239AEEA3')
,('386B04C6-303A-4840-8A51-D92B1EA2D339','2003-01-01 08:19:12.071','1980-12-03 15:01:03.026','Hersey Shakes','Removal of FB NOS',2441,'https://picsum.photos/1200/900?image=9','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','77666AA8-682C-4047-B075-04839281630A')
,('89B46EA8-B9A6-40E5-8DF3-DBA1095695F7','2009-06-22 03:58:18.671','2019-09-24 08:36:42.855','Mushroom - Lg - Cello','Excision of wrist NEC',3318,'https://picsum.photos/1200/900?image=23','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('3A0A0A89-9B3A-4046-BF2B-DEEE64A764D2','1980-02-20 19:44:23.924','1981-02-17 03:20:56.856','Cheese - Swiss','Other bone dx proc NEC',975,'https://picsum.photos/1200/900?image=11','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('A4811778-5070-4D70-8A9C-E6CB70DFCCA4','2005-05-17 08:39:00.444','2014-08-26 23:49:48.465','Cheese - Camembert','Mastoidectomy revision',253,'https://picsum.photos/1200/900?image=5','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('CBE43158-2010-4CB1-A8DE-F00DA16A7362','2009-06-22 03:58:18.671','2019-09-24 08:36:42.855','Ecolab - Balanced Fusion','Opn/oth part gastrectomy',1769,'https://picsum.photos/1200/900?image=14','B8B62196-6369-409D-B709-11C112DD023F','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
,('B8F0A771-339F-4602-A862-F7A51AFD5B79','1999-03-05 05:43:42.219','2006-10-27 13:42:49.099','MacBook Pro 2019','MacBook Pro 2019',4000,'https://picsum.photos/1200/900?image=3','90C9479E-A11C-4D6D-AAAA-0405B6C0EFCD','FALSE','80287EF3-987F-4312-A0C6-CCC2239AEEA3')
,('85B9767C-1A09-4C33-8E77-FAA25F1D69E1','1993-07-19 18:00:12.268','1988-08-26 10:59:03.959','Tarragon - Primerba, Paste','Tendon excision for grft',642,'https://picsum.photos/1200/900?image=15','EC186DDF-F430-44EC-84E5-205C93D84F14','FALSE','664690EE-A647-4B12-B87F-AF5C511187EB')
;

COMMIT;
