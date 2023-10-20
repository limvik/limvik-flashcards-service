CREATE TABLE IF NOT EXISTS `users` (
    `id` BINARY(16) NOT NULL PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS `algorithms` (
    `id` BINARY(16) NOT NULL PRIMARY KEY,
    `user_id` BINARY(16) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS `super_memo_2` (
    `algorithm_id` BINARY(16) NOT NULL PRIMARY KEY,
    `initial_interval` DOUBLE NOT NULL DEFAULT 1.0,
    `easiness_factor` DOUBLE NOT NULL DEFAULT 2.5,
    FOREIGN KEY (`algorithm_id`) REFERENCES `algorithms`(`id`) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS `decks` (
    `id` BINARY(16) NOT NULL PRIMARY KEY,
    `user_id` VARCHAR(36) NOT NULL,
    `name` VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS `deck_ancestors` (
    `deck_id` BINARY(16) NOT NULL,
    `parent_id` BINARY(16) NOT NULL,
    `depth` INT NOT NULL,
    PRIMARY KEY (`deck_id`, `parent_id`),
    FOREIGN KEY (`deck_id`) REFERENCES `decks`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`parent_id`) REFERENCES `decks`(`id`) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS `cards` (
    `id` BINARY(16) NOT NULL PRIMARY KEY,
    `deck_id` BINARY(16) NOT NULL,
    `user_id` BINARY(16) NOT NULL,
    `front` LONGTEXT NOT NULL,
    `back` LONGTEXT,
    `repetitions` INT NOT NULL DEFAULT 0,
    `interval` DOUBLE NOT NULL DEFAULT 1.0,
    FOREIGN KEY (`deck_id`) REFERENCES decks(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES users(`id`) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS `plans` (
    `id` BINARY(16) NOT NULL PRIMARY KEY,
    `card_id` BINARY(16) NOT NULL,
    `study_date_time` TIMESTAMP NOT NULL,
    `done` BOOLEAN NOT NULL,
    FOREIGN KEY (`card_id`) REFERENCES cards(`id`) ON DELETE CASCADE
    );