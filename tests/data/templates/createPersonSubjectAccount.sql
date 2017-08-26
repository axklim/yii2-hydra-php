-- BEGIN gudik\hydraphp\Builder::getQuery
DECLARE
MY1_SURNAME VARCHAR2(512);
MY1_FIRST_NAME VARCHAR2(512);
MY1_SECOND_NAME VARCHAR2(512);
MY1_COMMENT VARCHAR2(512);
MY1_REGION_ID NUMBER;
MY1_FLAT VARCHAR2(512);
MY1_BASE_SUBJECT_ID NUMBER;
MY2_LOGIN VARCHAR2(512);
MY2_SUBJECT_ID NUMBER;
MY3_ACCOUNT_ID NUMBER;
MY4_LOGIN VARCHAR2(512);
MY4_SUBJECT_ID NUMBER;
N_TMP1 NUMBER;
N_TMP2 NUMBER;
BEGIN
MAIN.INIT(
            vch_VC_IP => :plIp,
            vch_VC_USER => :plUser,
            vch_VC_PASS => :plPassword,
            vch_VC_APP_CODE => :plCode,
            vch_VC_CLN_APPID => :plApplicationId);
            MAIN.SET_ACTIVE_FIRM(num_N_FIRM_ID => 100);
MY1_SURNAME := :MY1_SURNAME;
MY1_FIRST_NAME := :MY1_FIRST_NAME;
MY1_SECOND_NAME := :MY1_SECOND_NAME;
MY1_COMMENT := :MY1_COMMENT;
MY1_REGION_ID := :MY1_REGION_ID;
MY1_FLAT := :MY1_FLAT;
MY2_LOGIN := :MY2_LOGIN;
MY4_LOGIN := :MY4_LOGIN;
-- BEGIN gudik\hydraphp\items\Person
--создание физ. лица;
          SI_PERSONS_PKG.SI_PERSONS_PUT(
            num_N_SUBJECT_ID      => MY1_BASE_SUBJECT_ID,
            num_N_FIRM_ID         => 100,
            vch_VC_FIRST_NAME     => MY1_FIRST_NAME,
            vch_VC_SECOND_NAME    => MY1_SECOND_NAME,
            vch_VC_SURNAME        => MY1_SURNAME,
            num_N_SUBJ_GROUP_ID   => 50215101,
            vch_VC_REM            => MY1_COMMENT,
            num_N_SEX_ID          => SYS_CONTEXT('CONST', 'SEX_Male'),
            num_N_SUBJ_STATE_ID   => SYS_CONTEXT('CONST', 'SUBJ_STATE_On'));

           -- добавление физ. лицу 'Фактического адреса';
          N_TMP1 := NULL;
          N_TMP2 := NULL;
          SI_ADDRESSES_PKG.SI_SUBJ_ADDRESSES_PUT_EX(
            num_N_SUBJ_ADDRESS_ID     => N_TMP1,
            num_N_SUBJECT_ID          => MY1_BASE_SUBJECT_ID,
            num_N_ADDRESS_ID          => N_TMP2,
            num_N_SUBJ_ADDR_TYPE_ID   => SYS_CONTEXT ('CONST' , 'BIND_ADDR_TYPE_Actual'),
            num_N_ADDR_STATE_ID       => SYS_CONTEXT ('CONST', 'ADDR_STATE_On'),
            ch_C_FL_MAIN              => 'Y',
            num_N_ADDR_TYPE_ID        => SYS_CONTEXT ('CONST', 'ADDR_TYPE_FactPlace'),
            num_N_REGION_ID           => MY1_REGION_ID,
            vch_VC_FLAT               => MY1_FLAT);
-- END gudik\hydraphp\items\Person
-- BEGIN gudik\hydraphp\items\Subject
--создание абонента;
          SI_SUBJECTS_PKG.SI_SUBJECTS_PUT(
            num_N_SUBJECT_ID      => MY2_SUBJECT_ID,
            num_N_SUBJ_TYPE_ID    => SYS_CONTEXT ('CONST', 'SUBJ_TYPE_User'),
            num_N_BASE_SUBJECT_ID => MY1_BASE_SUBJECT_ID,
            vch_VC_CODE           => MY2_LOGIN,
            num_N_FIRM_ID         => 100,
            num_N_SUBJ_GROUP_ID   => 53640201);

          --Привязка к фирме
          N_TMP1 := NULL;
          SI_SUBJECTS_PKG.SI_SUBJ_SUBJECTS_PUT(
            num_N_SUBJ_SUBJECT_ID       => N_TMP1,
            num_N_SUBJ_BIND_TYPE_ID     => SS_CONSTANTS_PKG_S.SUBJBIND_TYPE_UserOrgUnit,
            num_N_SUBJECT_ID            => MY2_SUBJECT_ID,
            num_N_SUBJECT_BIND_ID       => 100,
            ch_C_FL_MAIN                => 'N');-- END gudik\hydraphp\items\Subject
-- BEGIN gudik\hydraphp\items\Account
-- добавление Л/С абоненту;
            SI_USERS_PKG.USER_ACCOUNT_PUT(
                num_N_ACCOUNT_ID      => MY3_ACCOUNT_ID,
                num_N_SUBJECT_ID      => MY2_SUBJECT_ID,
                num_N_CURRENCY_ID     => SYS_CONTEXT ('CONST', 'CURR_Ruble'),
                vch_VC_ACCOUNT        => '');-- END gudik\hydraphp\items\Account
-- BEGIN gudik\hydraphp\items\Subject
--создание абонента;
          SI_SUBJECTS_PKG.SI_SUBJECTS_PUT(
            num_N_SUBJECT_ID      => MY4_SUBJECT_ID,
            num_N_SUBJ_TYPE_ID    => SYS_CONTEXT ('CONST', 'SUBJ_TYPE_User'),
            num_N_BASE_SUBJECT_ID => MY1_BASE_SUBJECT_ID,
            vch_VC_CODE           => MY4_LOGIN,
            num_N_FIRM_ID         => 100,
            num_N_SUBJ_GROUP_ID   => 53640201);

          --Привязка к фирме
          N_TMP1 := NULL;
          SI_SUBJECTS_PKG.SI_SUBJ_SUBJECTS_PUT(
            num_N_SUBJ_SUBJECT_ID       => N_TMP1,
            num_N_SUBJ_BIND_TYPE_ID     => SS_CONSTANTS_PKG_S.SUBJBIND_TYPE_UserOrgUnit,
            num_N_SUBJECT_ID            => MY4_SUBJECT_ID,
            num_N_SUBJECT_BIND_ID       => 100,
            ch_C_FL_MAIN                => 'N');-- END gudik\hydraphp\items\Subject

:MY1_BASE_SUBJECT_ID := MY1_BASE_SUBJECT_ID;
:MY2_SUBJECT_ID := MY2_SUBJECT_ID;
:MY3_ACCOUNT_ID := MY3_ACCOUNT_ID;
:MY4_SUBJECT_ID := MY4_SUBJECT_ID;
END;
-- END gudik\hydraphp\Builder::getQuery
