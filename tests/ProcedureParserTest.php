<?php
namespace gudik\hydraphp\tests;


use gudik\hydraphp\ProcedureParser;

class ProcedureParserTest extends TestCase
{
    public function testParsePlsFile()
    {
        $ar = ProcedureParser::parse('SI_SUBJECTS_PKG', 'SI_SUBJECTS_PUT');

        $this->assertEquals($ar, $this->_getReferenceArray());
        $this->assertTrue($ar == $this->_getReferenceArray());
    }

    public function _getReferenceArray()
    {
        return [
            'SUBJECT_ID' => [
                'direction' => 'OUT',
                'required'  => true,
                'field'     => 'num_N_SUBJECT_ID',
                'name'      => 'SUBJECT_ID',
                'type'      => 'NUMBER'
            ],
            'SUBJ_TYPE_ID' => [
                'direction' => 'IN',
                'required'  => true,
                'field'     => 'num_N_SUBJ_TYPE_ID',
                'name'      => 'SUBJ_TYPE_ID',
                'type'      => 'NUMBER'
            ],
            'BASE_SUBJECT_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_BASE_SUBJECT_ID',
                'name'      => 'BASE_SUBJECT_ID',
                'type'      => 'NUMBER'
            ],
            'SUBJ_STATE_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_SUBJ_STATE_ID',
                'name'      => 'SUBJ_STATE_ID',
                'type'      => 'NUMBER'
            ],
            'PARENT_SUBJ_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_PARENT_SUBJ_ID',
                'name'      => 'PARENT_SUBJ_ID',
                'type'      => 'NUMBER'
            ],
            'OWNER_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_OWNER_ID',
                'name'      => 'OWNER_ID',
                'type'      => 'NUMBER'
            ],
            'NAME' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'vch_VC_NAME',
                'name'      => 'NAME',
                'type'      => 'VARCHAR(512)'
            ],
            'CODE' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'vch_VC_CODE',
                'name'      => 'CODE',
                'type'      => 'VARCHAR(512)'
            ],
            'REM' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'vch_VC_REM',
                'name'      => 'REM',
                'type'      => 'VARCHAR(512)'
            ],
            'FIRM_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_FIRM_ID',
                'name'      => 'FIRM_ID',
                'type'      => 'NUMBER'
            ],
            'REGION_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_REGION_ID',
                'name'      => 'REGION_ID',
                'type'      => 'NUMBER'
            ],
            'ACTUALIZE' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'dt_D_ACTUALIZE',
                'name'      => 'ACTUALIZE',
                'type'      => 'DATETIME'
            ],
            'CODE_ADD' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'vch_VC_CODE_ADD',
                'name'      => 'CODE_ADD',
                'type'      => 'VARCHAR(512)'
            ],
            'SERVER_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_SERVER_ID',
                'name'      => 'SERVER_ID',
                'type'      => 'NUMBER'
            ],
            'SUBJ_GROUP_ID' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_SUBJ_GROUP_ID',
                'name'      => 'SUBJ_GROUP_ID',
                'type'      => 'NUMBER'
            ],
            'SCN' => [
                'direction' => 'IN',
                'required'  => false,
                'field'     => 'num_N_SCN',
                'name'      => 'SCN',
                'type'      => 'NUMBER'
            ],
        ];
    }
}