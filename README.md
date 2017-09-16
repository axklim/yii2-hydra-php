[![CircleCI](https://circleci.com/gh/axklim/yii2-hydra-php.svg?style=svg&circle-token=f7c46ab9437728466afa47bb19344f62782dc3fc)](https://circleci.com/gh/axklim/yii2-hydra-php)

Simplest API for Latera Hydra Billing on PHP

### Install
```bash
composer require gudik/yii2-hydraphp
``` 

### Test
```bash
vendor/bin/phpunit
``` 

### Use
Before use you will need to Packages: `SI_PERSONS_PKG.pls`, `SI_SUBJECTS_PKG.pls` and others.
Can get them from Hydra database using Oracle sqlDeveloper and save to `./src/hydra/packages/`  

#### Common requirements
```php
<?php
namespace gudik\hydraphp\dev;
use gudik\hydraphp\Builder;
use gudik\hydraphp\db\Connection;
use gudik\hydraphp\OCIHelper;

$connection = new Connection([
    'dsn' => 'ip/dbName',
    'username' => 'userName',
    'password' => 'userPassword',
    'plIp' => 'hydraAppIp',
    'plUser' => 'hydraAppUserName',
    'plPassword' => 'hydraAppUserPassword',
    'plCode' => 'hydraAppApplicationName',
    'plApplicationId' => 'HYDRA_PHP',
]);

$hydra = new Builder();
$person = $hydra->create('SI_PERSONS_PKG.SI_PERSONS_PUT');
$person->SURNAME = 'Surname1';
$person->FIRST_NAME = 'Firstname2';
$person->SECOND_NAME = 'Secondname3';
$person->REM = 'Comment';
OCIHelper::create($connection, $hydra)->execute();
?>
```

#### Linking entities
```php
    ...
    $faker = $this->faker();
    // Create Hydra entities
    $hydra = new Builder();
    $person = $hydra->create('SI_PERSONS_PKG.SI_PERSONS_PUT');
    $user = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJECTS_PUT');
    $account = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJ_ACCOUNTS_PUT');
    // Fill entity Person 
    $person->SURNAME = $faker->lastName;
    $person->FIRST_NAME = $faker->firstName;
    $person->SECOND_NAME = $faker->firstName;
    $person->REM = $faker->text;
    // Fill entity User
    $user->CODE = $faker->userName;
    $user->SUBJ_TYPE_ID = 2001;
    $user->SUBJ_GROUP_ID = 53640201;
    // Link User and Person on Person->SUBJECT_ID <= User->BASE_SUBJECT_ID
    $user->BASE_SUBJECT_ID($person->SUBJECT_ID());
    // Fill entity Account
    $account->ACCOUNT_TYPE_ID = 2042;
    $account->CURRENCY_ID = 1044;
    // Link Account and User on User->SUBJECT_ID <= Account->SUBJECT_ID
    $account->SUBJECT_ID($user->SUBJECT_ID());
    // Add another User for Person
    $otherUser = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJECTS_PUT');
    $otherUser->CODE = $faker->userName;
    $otherUser->SUBJ_TYPE_ID = 2001;
    $otherUser->SUBJ_GROUP_ID = 53640201;
    $otherUser->BASE_SUBJECT_ID($person->SUBJECT_ID());
    // Build and run pl/sql
    OCIHelper::create($connection, $hydra)->execute();
    ...
```