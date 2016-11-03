
CREATE TYPE user_permissions AS ENUM('user', 'admin', 'moderator');

CREATE TABLE "user" (
	"id" serial NOT NULL,
	"login" varchar NOT NULL UNIQUE CHECK ( char_length("login") >= 5 ),
	"password" varchar NOT NULL CHECK ( char_length("password") >= 6 ),
	"phone_number" varchar NOT NULL UNIQUE CHECK ( char_length("phone_number") >= 10 ),
	"email" varchar NOT NULL UNIQUE CHECK(char_length("email") >= 6),
	"permission" user_permissions NOT NULL DEFAULT 'user',
	"first_name" varchar NOT NULL,
	"last_name" varchar NOT NULL,
	"sex" varchar,
	"birth_date" DATE,
	"location_id" integer NOT NULL,
	"description" TEXT DEFAULT 'На даний момент опис відсутній',
	"avatar_address" TEXT DEFAULT 'empty_avatars.png',
	"date_of_creation" DATE DEFAULT current_date,
	CONSTRAINT user_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "advertisement" (
	"id" serial NOT NULL,
	"user_id" integer NOT NULL,
	"title" TEXT NOT NULL,
	"price" float,
	"location_id" integer NOT NULL,
	"category_id" integer NOT NULL,
	"description" TEXT DEFAULT 'На даний момент опис відсутній',
	"date_of_creation" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	"image_address" TEXT DEFAULT 'empty.png',
	CONSTRAINT advertisement_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "location" (
	"id" serial NOT NULL,
	"region_id" integer NOT NULL,
	"city_id" integer NOT NULL,
	CONSTRAINT location_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "region" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT region_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "city" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT city_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "category" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT category_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "comment" (
	"id" serial NOT NULL,
	"user_id" integer NOT NULL,
	"advertisement_id" integer NOT NULL,
	"user_comment" TEXT NOT NULL,
	"comment_date" DATE DEFAULT current_date,
	CONSTRAINT comment_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "mark" (
	"id" serial NOT NULL,
	"user_id" integer NOT NULL,
	"advertisement_id" integer NOT NULL,
	"user_mark" integer NOT NULL,
	CONSTRAINT mark_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "user" ADD CONSTRAINT "user_fk0" FOREIGN KEY ("location_id") REFERENCES "location"("id");

ALTER TABLE "advertisement" ADD CONSTRAINT "advertisement_fk0" FOREIGN KEY ("user_id") REFERENCES "user"("id");
ALTER TABLE "advertisement" ADD CONSTRAINT "advertisement_fk1" FOREIGN KEY ("location_id") REFERENCES "location"("id");
ALTER TABLE "advertisement" ADD CONSTRAINT "advertisement_fk2" FOREIGN KEY ("category_id") REFERENCES "category"("id");

ALTER TABLE "location" ADD CONSTRAINT "location_fk0" FOREIGN KEY ("region_id") REFERENCES "region"("id");
ALTER TABLE "location" ADD CONSTRAINT "location_fk1" FOREIGN KEY ("city_id") REFERENCES "city"("id");




ALTER TABLE "comment" ADD CONSTRAINT "comment_fk0" FOREIGN KEY ("user_id") REFERENCES "user"("id");
ALTER TABLE "comment" ADD CONSTRAINT "comment_fk1" FOREIGN KEY ("advertisement_id") REFERENCES "advertisement"("id");

ALTER TABLE "mark" ADD CONSTRAINT "mark_fk0" FOREIGN KEY ("user_id") REFERENCES "user"("id");
ALTER TABLE "mark" ADD CONSTRAINT "mark_fk1" FOREIGN KEY ("advertisement_id") REFERENCES "advertisement"("id");
