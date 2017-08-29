<?php

namespace gudik\hydraphp\tests;


use DomainException;
use gudik\hydraphp\Procedure;

class ProcedureTest extends TestCase
{
    /**
     * @expectedException DomainException
     */
    public function testPropertyNotFoundOnSet()
    {
        $procedure = new Procedure('SI_PERSONS_PKG', 'SI_PERSONS_PUT');
        $procedure->PROPERTIES_WHICH_IS_NOT = 'some string';
    }

    /**
     * @expectedException DomainException
     */
    public function testPropertyNotFoundOnGet()
    {
        $procedure = new Procedure('SI_PERSONS_PKG', 'SI_PERSONS_PUT');
        $procedure->PROPERTIES_WHICH_IS_NOT;
    }

    /**
     * @expectedException DomainException
     */
    public function testPropertyNotFoundOnCall()
    {
        $procedure = new Procedure('SI_PERSONS_PKG', 'SI_PERSONS_PUT');
        $procedure->PROPERTIES_WHICH_IS_NOT();
    }
}