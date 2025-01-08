-- Insert 100 users
INSERT INTO "users" ("id", "email", "password", "name", "updatedAt", "createdAt", "deletedAt", "isDeleted")
SELECT
    gen_random_uuid(),
    'user' || i || '@example.com',
    'password123',
    'User ' || i,
    NOW(),
    NOW(),
    NULL,
    false
FROM generate_series(1, 100) AS i;

-- Insert 100 color palettes
INSERT INTO "color_palettes" ("id", "userId", "primaryColor", "secondaryColor", "thirdColor", "updatedAt", "createdAt", "deletedAt", "isDeleted")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0'),
    lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0'),
    lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0') || lpad(to_hex((random()*255)::int), 2, '0'),
    NOW(),
    NOW(),
    NULL,
    false
FROM generate_series(1, 100);

-- Insert 100 map arts
INSERT INTO "map_arts" ("id", "userId", "colorPaletteId", "title", "url", "latitude", "longitude", "createdAt")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    (SELECT "id" FROM "color_palettes" ORDER BY RANDOM() LIMIT 1),
    'Art Title ' || i,
    'https://example.com/art' || i || '.jpg',
    round((-90 + random() * 180)::numeric, 6),
    round((-180 + random() * 360)::numeric, 6),
    NOW()
FROM generate_series(1, 100) AS i;

-- Insert 100 comments
INSERT INTO "users_comments_map_arts" ("id", "mapArtCommentedId", "userWhoCommentedId", "comment", "createdAt")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "map_arts" ORDER BY RANDOM() LIMIT 1),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    'Nice artwork ' || i,
    NOW()
FROM generate_series(1, 100) AS i;

-- Insert 100 likes
INSERT INTO "users_likes_map_arts" ("id", "postLikedId", "userWhoLikedId", "createdAt")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "map_arts" ORDER BY RANDOM() LIMIT 1),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    NOW()
FROM generate_series(1, 100);

-- Insert 100 follows
INSERT INTO "users_follows_users" ("id", "followingUserId", "followedUserId", "createdAt")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    NOW()
FROM generate_series(1, 100);

-- Insert 100 favorites
INSERT INTO "users_favorites_posts" ("id", "postId", "userId", "createdAt")
SELECT
    gen_random_uuid(),
    (SELECT "id" FROM "map_arts" ORDER BY RANDOM() LIMIT 1),
    (SELECT "id" FROM "users" ORDER BY RANDOM() LIMIT 1),
    NOW()
FROM generate_series(1, 100);
