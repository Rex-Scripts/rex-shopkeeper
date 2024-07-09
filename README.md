# RexshackGaming
- discord : https://discord.gg/YUV7ebzkqs
- youtube : https://www.youtube.com/@rexshack/videos
- tebex store : https://rexshackgaming.tebex.io/
- support me : https://ko-fi.com/rexshackgaming

# rex-shopkeeper
- For RSG RedM Framework : https://discord.gg/eW3ADkf4Af

# Dependancies
- rsg-core
- rsg-target
- ox_lib

# Installation:
- ensure that the dependancies are added and started
- add rex-shopkeeper to your resources folder
- items have already been added to rsg-core check you have the latest version
- images have already been added to rsg-core check you have the latest version
- add the following table to your database (see below)

# Add Jobs
- add jobs to "\rsg-core\shared\jobs.lua"
```lua
    ['valshopkeeper'] = {
        label = 'Valentine Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['rhoshopkeeper'] = {
        label = 'Rhodes Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['strshopkeeper'] = {
        label = 'Strawberry Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['annshopkeeper'] = {
        label = 'Annesburg Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['stdshopkeeper'] = {
        label = 'StDenis Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['tumshopkeeper'] = {
        label = 'Tumbleweed Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['armshopkeeper'] = {
        label = 'Armadillo Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['blkshopkeeper'] = {
        label = 'Blackwater Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
    ['vanshopkeeper'] = {
        label = 'Van-Horn Shopkeeper',
        type = 'shopkeeper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = { name = 'Staff', payment = 5 },
            ['1'] = { name = 'Manager', isboss = true, payment = 15 },
        },
    },
```

# Add SQL
```sql
CREATE TABLE `rex_shopkeeper` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `shopkeeperid` varchar(50) DEFAULT NULL,
    `owner` varchar(50) DEFAULT NULL,
    `rent` int(3) NOT NULL DEFAULT 0,
    `status` varchar(50) DEFAULT 'closed',
    `money` double(11,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `rex_shopkeeper_stock` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `shopkeeperid` varchar(50) DEFAULT NULL,
    `item` varchar(50) DEFAULT NULL,
    `stock` int(11) NOT NULL DEFAULT 0,
    `price` double(11,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `rex_shopkeeper` (`shopkeeperid`, `owner`, `money`) VALUES
('valshopkeeper', 'vacant', 0.00),
('rhoshopkeeper', 'vacant', 0.00),
('strshopkeeper', 'vacant', 0.00),
('annshopkeeper', 'vacant', 0.00),
('stdshopkeeper', 'vacant', 0.00),
('tumshopkeeper', 'vacant', 0.00),
('armshopkeeper', 'vacant', 0.00),
('blkshopkeeper', 'vacant', 0.00),
('vanshopkeeper', 'vacant', 0.00);

INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES
('valshopkeeper', 0, 'boss'),
('rhoshopkeeper', 0, 'boss'),
('strshopkeeper', 0, 'boss'),
('annshopkeeper', 0, 'boss'),
('stdshopkeeper', 0, 'boss'),
('tumshopkeeper', 0, 'boss'),
('armshopkeeper', 0, 'boss'),
('blkshopkeeper', 0, 'boss'),
('vanshopkeeper', 0, 'boss');
```

# Starting the resource:
- add the following to your server.cfg file : ensure rex-shopkeeper
