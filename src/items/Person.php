<?php

namespace gudik\hydraphp\items;


class Person extends BaseItem implements BaseItemInterface
{
    public function in()
    {
        return ['MY_SURNAME'=> 'VARCHAR2(512)',
            'MY_FIRST_NAME' => 'VARCHAR2(512)',
            'MY_SECOND_NAME'=> 'VARCHAR2(512)',
            'MY_COMMENT'    => 'VARCHAR2(512)',
            'MY_REGION_ID'  => 'NUMBER',
            'MY_FLAT'       => 'VARCHAR2(512)'
        ];
    }

    public function out()
    {
        return ['MY_BASE_SUBJECT_ID' => 'NUMBER'];
    }

    public function getSql()
    {
        return "--создание физ. лица;
          SI_PERSONS_PKG.SI_PERSONS_PUT(
            num_N_SUBJECT_ID      => MY_BASE_SUBJECT_ID,
            num_N_FIRM_ID         => 100,
            vch_VC_FIRST_NAME     => MY_FIRST_NAME,
            vch_VC_SECOND_NAME    => MY_SECOND_NAME,
            vch_VC_SURNAME        => MY_SURNAME,
            num_N_SUBJ_GROUP_ID   => 50215101,
            vch_VC_REM            => MY_COMMENT,
            num_N_SEX_ID          => SYS_CONTEXT('CONST', 'SEX_Male'),
            num_N_SUBJ_STATE_ID   => SYS_CONTEXT('CONST', 'SUBJ_STATE_On'));
        
           -- добавление физ. лицу 'Фактического адреса';
          N_TMP1 := NULL;
          N_TMP2 := NULL;
          SI_ADDRESSES_PKG.SI_SUBJ_ADDRESSES_PUT_EX(
            num_N_SUBJ_ADDRESS_ID     => N_TMP1,
            num_N_SUBJECT_ID          => MY_BASE_SUBJECT_ID,
            num_N_ADDRESS_ID          => N_TMP2,
            num_N_SUBJ_ADDR_TYPE_ID   => SYS_CONTEXT ('CONST' , 'BIND_ADDR_TYPE_Actual'),
            num_N_ADDR_STATE_ID       => SYS_CONTEXT ('CONST', 'ADDR_STATE_On'),
            ch_C_FL_MAIN              => 'Y',
            num_N_ADDR_TYPE_ID        => SYS_CONTEXT ('CONST', 'ADDR_TYPE_FactPlace'),
            num_N_REGION_ID           => MY_REGION_ID,
            vch_VC_FLAT               => MY_FLAT);
";
    }
}
