<?php
namespace gudik\hydraphp\tests;


use gudik\hydraphp\Builder;
use gudik\hydraphp\Param;

class BuildTest extends TestCase
{
    public function testSimple()
    {
        $hydra = new Builder();
        $person = $hydra->create('SI_PERSONS_PKG.SI_PERSONS_PUT');
        $person->SURNAME = $this->faker()->lastName;
        $person->FIRST_NAME = $this->faker()->firstName;
        $person->SECOND_NAME = $this->faker()->firstName;
        $person->REM = $this->faker()->text;
        $this->_setBindPostfix($hydra, '112233');
        $this->assertEquals($hydra->sql(), $this->getTemplate('createPerson'));
    }

    public function testPersonSubjectAccount()
    {
        $faker = $this->faker();
        $hydra = new Builder();
        $person = $hydra->create('SI_PERSONS_PKG.SI_PERSONS_PUT');
        $user = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJECTS_PUT');
        $account = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJ_ACCOUNTS_PUT');
        $person->SURNAME = $faker->lastName;
        $person->FIRST_NAME = $faker->firstName;
        $person->SECOND_NAME = $faker->firstName;
        $person->REM = $faker->text;
        $user->CODE = $faker->userName;
        $user->SUBJ_TYPE_ID = 2001;
        $user->SUBJ_GROUP_ID = 53640201;
        $user->BASE_SUBJECT_ID($person->SUBJECT_ID());
        $account->ACCOUNT_TYPE_ID = 2042;
        $account->CURRENCY_ID = 1044;
        $account->SUBJECT_ID($user->SUBJECT_ID());
        $otherUser = $hydra->create('SI_SUBJECTS_PKG.SI_SUBJECTS_PUT');
        $otherUser->CODE = $faker->userName;
        $otherUser->SUBJ_TYPE_ID = 2001;
        $otherUser->SUBJ_GROUP_ID = 53640201;
        $otherUser->BASE_SUBJECT_ID($person->SUBJECT_ID());
        $this->_setBindPostfix($hydra, '11223344');
        $this->assertEquals($hydra->sql(), $this->getTemplate('createPersonSubjectAccount'));
    }

    public function _setBindPostfix(Builder $hydra, $postfix)
    {
        $param = $hydra->getParams();
        array_walk_recursive($param, function($param) use($postfix){
            /** @var Param $param */
            $param->bind = $param->name . '_' . $postfix;
        });
    }
}