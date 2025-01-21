// Connect to the database
use [martp-database];

// Generate 5000 users
for (let i = 0; i < 5000; i++) {
    db.users.insertOne({
        id: UUID(),
        email: `user${i}@example.com`,
        password: `password${i}`,
        name: `User ${i}`,
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 color palettes
for (let i = 0; i < 5000; i++) {
    db.color_palettes.insertOne({
        id: UUID(),
        userId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        primaryColor: Math.floor(Math.random() * 16777215).toString(16).padStart(6, '0'),
        secondaryColor: Math.floor(Math.random() * 16777215).toString(16).padStart(6, '0'),
        thirdColor: Math.floor(Math.random() * 16777215).toString(16).padStart(6, '0'),
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 map arts
for (let i = 0; i < 5000; i++) {
    db.map_arts.insertOne({
        id: UUID(),
        title: `Map Art ${i}`,
        description: `Description for map art ${i}`,
        userId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        colorPaletteId: db.color_palettes.aggregate([{ $sample: { size: 1 } }]).next().id,
        url: `https://example.com/map_art_${i}.jpg`,
        latitude: (Math.random() * 180 - 90).toFixed(6),
        longitude: (Math.random() * 360 - 180).toFixed(6),
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 user comments on map arts
for (let i = 0; i < 5000; i++) {
    db.users_comments_map_arts.insertOne({
        id: UUID(),
        mapArtCommentedId: db.map_arts.aggregate([{ $sample: { size: 1 } }]).next().id,
        userWhoCommentedId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        comment: `This is comment number ${i}`,
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 user likes on map arts
for (let i = 0; i < 5000; i++) {
    db.users_likes_map_arts.insertOne({
        id: UUID(),
        postLikedId: db.map_arts.aggregate([{ $sample: { size: 1 } }]).next().id,
        userWhoLikedId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 user follows
for (let i = 0; i < 5000; i++) {
    db.users_follows_users.insertOne({
        id: UUID(),
        followingUserId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        followedUserId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

// Generate 5000 user favorites posts
for (let i = 0; i < 5000; i++) {
    db.users_favorites_posts.insertOne({
        id: UUID(),
        postId: db.map_arts.aggregate([{ $sample: { size: 1 } }]).next().id,
        userId: db.users.aggregate([{ $sample: { size: 1 } }]).next().id,
        updatedAt: new Date(),
        createdAt: new Date(),
        deletedAt: null,
        isDeleted: false
    });
}

print("Database populated with 5000 entries in each collection!");
