INSERT INTO "users" ("id", "email", "password", "name", "createdAt")
VALUES
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'user1@example.com', 'hashed_password1', 'User One', NOW()),
    ('b1946c30-7772-49a3-a8a4-01c8d5238b01', 'user2@example.com', 'hashed_password2', 'User Two', NOW()),
    ('c2f72c61-4e8c-4c8d-b6f6-02a0e0248c01', 'user3@example.com', 'hashed_password3', 'User Three', NOW());

INSERT INTO "color_palettes" ("id", "userId", "primaryColor", "secondaryColor", "thirdColor", "createdAt")
VALUES
    ('d3e08c92-1f0b-4ef8-bb6d-6bb9bd380a12', (SELECT "id" FROM "users" WHERE "email" = 'user1@example.com'), 'FF0000', '00FF00', '0000FF', NOW()),
    ('e4f34c31-2772-49a3-a8a4-01c8d5238b02', (SELECT "id" FROM "users" WHERE "email" = 'user2@example.com'), 'FFFFFF', '000000', '808080', NOW());

INSERT INTO "map_arts" ("id", "userId", "colorPaletteId", "title", "url", "latitude", "longitude", "createdAt")
VALUES
    ('27c4b8cb-879a-4fb2-bbec-2769330f1e8b', (SELECT "id" FROM "users" WHERE "email" = 'user1@example.com'), (SELECT "id" FROM "color_palettes" WHERE "primaryColor" = 'FF0000'), 'Red Art', 'https://example.com/red_art.jpg', -33.8688, 151.2093, NOW()),
    ('0dfb3c88-6816-4076-afa9-b9eaa111f46c', (SELECT "id" FROM "users" WHERE "email" = 'user2@example.com'), (SELECT "id" FROM "color_palettes" WHERE "primaryColor" = 'FFFFFF'), 'Black & White Art', 'https://example.com/bw_art.jpg', 37.7749, -122.4194, NOW());

INSERT INTO "users_comments_map_arts" ("id", "mapArtCommentedId", "userWhoCommentedId", "comment", "createdAt")
VALUES
    ('cdf034a6-bca5-4a59-b942-6c61bdf539c0', (SELECT "id" FROM "map_arts" WHERE "title" = 'Red Art'), (SELECT "id" FROM "users" WHERE "email" = 'user2@example.com'), 'Nice colors!', NOW());

INSERT INTO "users_likes_map_arts" ("id", "postLikedId", "userWhoLikedId", "createdAt")
VALUES
    ('1e7fc362-ad1c-455a-9181-6017bf5277c8', (SELECT "id" FROM "map_arts" WHERE "title" = 'Black & White Art'), (SELECT "id" FROM "users" WHERE "email" = 'user1@example.com'), NOW());

INSERT INTO "users_follows_users" ("id", "followingUserId", "followedUserId", "createdAt")
VALUES
    ('58767dec-7482-4e50-9a2a-24a882a79a2a', (SELECT "id" FROM "users" WHERE "email" = 'user1@example.com'), (SELECT "id" FROM "users" WHERE "email" = 'user2@example.com'), NOW());

INSERT INTO "users_favorites_posts" ("id", "postId", "userId", "createdAt")
VALUES
    ('e715979e-470b-4a6b-b8db-c02abae158f9', (SELECT "id" FROM "map_arts" WHERE "title" = 'Red Art'), (SELECT "id" FROM "users" WHERE "email" = 'user2@example.com'), NOW());