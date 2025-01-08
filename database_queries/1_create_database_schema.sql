CREATE TABLE "users" (
  "id" uuid PRIMARY KEY NOT NULL,
  "email" varchar,
  "password" varchar,
  "name" text,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "color_palettes" (
  "id" uuid PRIMARY KEY,
  "userId" uuid,
  "primaryColor" varchar(6) NOT NULL,
  "secondaryColor" varchar(6) NOT NULL,
  "thirdColor" varchar(6) NOT NULL,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "map_arts" (
  "id" uuid PRIMARY KEY NOT NULL,
  "title" varchar(50) NOT NULL,
  "description" varchar(100) DEFAULT null,
  "userId" uuid,
  "colorPaletteId" uuid,
  "url" varchar(512) NOT NULL,
  "latitude" decimal(8,6),
  "longitude" decimal(9,6),
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "users_comments_map_arts" (
  "id" uuid PRIMARY KEY,
  "mapArtCommentedId" uuid,
  "userWhoCommentedId" uuid,
  "comment" varchar(256) NOT NULL,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "users_likes_map_arts" (
  "id" uuid PRIMARY KEY,
  "postLikedId" uuid,
  "userWhoLikedId" uuid,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "users_follows_users" (
  "id" uuid PRIMARY KEY,
  "followingUserId" uuid,
  "followedUserId" uuid,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

CREATE TABLE "users_favorites_posts" (
  "id" uuid PRIMARY KEY,
  "postId" uuid,
  "userId" uuid,
  "updatedAt" timestamp,
  "createdAt" timestamp,
  "deletedAt" timestamp DEFAULT null,
  "isDeleted" bool DEFAULT false
);

ALTER TABLE "color_palettes" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "map_arts" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "map_arts" ADD FOREIGN KEY ("colorPaletteId") REFERENCES "color_palettes" ("id");

ALTER TABLE "users_comments_map_arts" ADD FOREIGN KEY ("mapArtCommentedId") REFERENCES "map_arts" ("id");

ALTER TABLE "users_comments_map_arts" ADD FOREIGN KEY ("userWhoCommentedId") REFERENCES "users" ("id");

ALTER TABLE "users_likes_map_arts" ADD FOREIGN KEY ("postLikedId") REFERENCES "map_arts" ("id");

ALTER TABLE "users_likes_map_arts" ADD FOREIGN KEY ("userWhoLikedId") REFERENCES "users" ("id");

ALTER TABLE "users_follows_users" ADD FOREIGN KEY ("followingUserId") REFERENCES "users" ("id");

ALTER TABLE "users_follows_users" ADD FOREIGN KEY ("followedUserId") REFERENCES "users" ("id");

ALTER TABLE "users_favorites_posts" ADD FOREIGN KEY ("postId") REFERENCES "map_arts" ("id");

ALTER TABLE "users_favorites_posts" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");