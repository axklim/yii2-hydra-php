<?php

namespace gudik\hydraphp\items;


class Subject extends BaseItem implements BaseItemInterface
{
    public function in()
    {
        return ['MY_BASE_SUBJECT_ID' => 'NUMBER', 'MY_LOGIN' => 'VARCHAR2(512)'];
    }

    public function out()
    {
        return ['MY_SUBJECT_ID' => 'NUMBER'];
    }

    public function getSql()
    {
        return "--создание абонента;
          SI_SUBJECTS_PKG.SI_SUBJECTS_PUT(
            num_N_SUBJECT_ID      => MY_SUBJECT_ID,
            num_N_SUBJ_TYPE_ID    => SYS_CONTEXT ('CONST', 'SUBJ_TYPE_User'),
            num_N_BASE_SUBJECT_ID => MY_BASE_SUBJECT_ID,
            vch_VC_CODE           => MY_LOGIN,
            num_N_FIRM_ID         => 100,
            num_N_SUBJ_GROUP_ID   => 53640201);
        
          --Привязка к фирме
          N_TMP1 := NULL;
          SI_SUBJECTS_PKG.SI_SUBJ_SUBJECTS_PUT(
            num_N_SUBJ_SUBJECT_ID       => N_TMP1,
            num_N_SUBJ_BIND_TYPE_ID     => SS_CONSTANTS_PKG_S.SUBJBIND_TYPE_UserOrgUnit,
            num_N_SUBJECT_ID            => MY_SUBJECT_ID,
            num_N_SUBJECT_BIND_ID       => 100,
            ch_C_FL_MAIN                => 'N');";
    }
}
