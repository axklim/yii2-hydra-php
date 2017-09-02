<?php

namespace gudik\hydraphp\tests;


use gudik\hydraphp\Builder;

class BuilderTest extends TestCase
{
    public function testReturnEmptyArry()
    {
        $builder = new Builder();
        $this->assertEquals($builder->getBinds(), []);
        $this->assertEquals($builder->getInParams(), []);
        $this->assertEquals($builder->getOutParams(), []);
        $this->assertEquals($builder->getParams(), []);
    }

    public function testReturnArray()
    {
        $builder = new Builder();
        $person = $builder->create('SI_PERSONS_PKG.SI_PERSONS_PUT');
        $this->assertArrayNotHasKey(':FIRST_NAME_3750255', $builder->getBinds());
        $this->assertArrayNotHasKey('FIRST_NAME', $builder->getInParams());
        $this->assertArrayNotHasKey('SUBJECT_ID', $builder->getOutParams());
        $this->assertArrayNotHasKey('FIRST_NAME', $builder->getParams());
        $this->assertArrayNotHasKey('SUBJECT_ID', $builder->getParams());
    }
}