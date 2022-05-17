CREATE TABLE `location` (
                            `id` int(11) NOT NULL AUTO_INCREMENT,
                            `mac_address` varchar(12) NOT NULL,
                            `label` varchar(255) NOT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `role` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `label` varchar(255) DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) NOT NULL,
                        `rfid` varchar(255) NOT NULL,
                        `password` varchar(255) DEFAULT NULL,
                        `role` int(11) DEFAULT NULL,
                        `current_loc` int(11) NOT NULL DEFAULT 1,
                        PRIMARY KEY (`id`),
                        KEY `role` (`role`),
                        KEY `currentLoc` (`current_loc`),
                        CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role`) REFERENCES `role` (`id`),
                        CONSTRAINT `user_ibfk_2` FOREIGN KEY (`current_loc`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `location_temperature` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT,
                                        `loc_id` int(11) DEFAULT NULL,
                                        `timestamp` datetime DEFAULT NULL,
                                        `temperature` float DEFAULT NULL,
                                        PRIMARY KEY (`id`),
                                        KEY `locId` (`loc_id`),
                                        CONSTRAINT `location_temperature_ibfk_1` FOREIGN KEY (`loc_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `location_authorization` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
                                          `user_id` int(11) DEFAULT NULL,
                                          `loc_id` int(11) DEFAULT NULL,
                                          PRIMARY KEY (`id`),
                                          KEY `userId` (`user_id`),
                                          KEY `locId` (`loc_id`),
                                          CONSTRAINT `location_authorization_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
                                          CONSTRAINT `location_authorization_ibfk_2` FOREIGN KEY (`loc_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `authorization_history` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT,
                                         `user_id` int(11) DEFAULT NULL,
                                         `loc_id` int(11) DEFAULT NULL,
                                         `timestamp` datetime DEFAULT NULL,
                                         `status` varchar(255) DEFAULT NULL,
                                         PRIMARY KEY (`id`),
                                         KEY `userId` (`user_id`),
                                         KEY `locId` (`loc_id`),
                                         CONSTRAINT `authorization_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
                                         CONSTRAINT `authorization_history_ibfk_2` FOREIGN KEY (`loc_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;