<?php
namespace gudik\hydraphp\tests;


use gudik\hydraphp\Builder;
use gudik\hydraphp\Connection;
use gudik\hydraphp\items\Person;

class BuildTest extends TestCase
{
    public function testSimple()
    {
        $hydra = new Builder();
        $person = new Person();
        $person['MY_SURNAME'] = 'surname';
        $person['MY_FIRST_NAME'] = 'name';
        $person['MY_SECOND_NAME'] = 'name2';
        $person['MY_COMMENT'] = 'comment';
        $person['MY_REGION_ID'] = 9045576301;
        $person['MY_FLAT'] = '5a';
        $hydra->link($person, null);
        $this->assertEquals($hydra->getQuery(), $this->getTemplate('createPerson'));
        $this->assertTrue(1 == 1);
    }
}