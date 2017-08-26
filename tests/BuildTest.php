<?php
namespace gudik\hydraphp\tests;


use gudik\hydraphp\Builder;
use gudik\hydraphp\items\Account;
use gudik\hydraphp\items\Person;
use gudik\hydraphp\items\Subject;

class BuildTest extends TestCase
{
    public function testSimple()
    {
        $hydra = new Builder();
        $person = new Person();
        $person['MY_SURNAME'] = $this->faker()->lastName;
        $person['MY_FIRST_NAME'] = $this->faker()->firstName;
        $person['MY_SECOND_NAME'] = $this->faker()->firstName;
        $person['MY_COMMENT'] = $this->faker()->text;
        $person['MY_REGION_ID'] = $this->faker()->randomNumber;
        $person['MY_FLAT'] = $this->faker()->buildingNumber;
        $hydra->link($person, null);
        $this->assertEquals($hydra->getQuery(), $this->getTemplate('createPerson'));
    }

    public function testPersonSubjectAccount()
    {
        $hydra = new Builder();
        $person = new Person();
        $person['MY_SURNAME'] = $this->faker()->lastName;
        $person['MY_FIRST_NAME'] = $this->faker()->firstName;
        $person['MY_SECOND_NAME'] = $this->faker()->firstName;
        $person['MY_COMMENT'] = $this->faker()->text;
        $person['MY_REGION_ID'] = $this->faker()->randomNumber;
        $person['MY_FLAT'] = $this->faker()->buildingNumber;
        $hydra->link($person, null);
        $subject = new Subject();
        $subject['MY_LOGIN'] = $this->faker()->userName;
        $hydra->link($subject, $person);
        $account = new Account();
        $hydra->link($account, $subject);
        $subject = new Subject();
        $subject['MY_LOGIN'] = $this->faker()->userName;
        $hydra->link($subject, $person);
        $this->assertEquals($hydra->getQuery(), $this->getTemplate('createPersonSubjectAccount'));
    }
}