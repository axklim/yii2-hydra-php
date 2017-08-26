-- BEGIN gudik\hydraphp\Builder::getQuery
DECLARE
MY1_SURNAME VARCHAR2(512);
MY1_FIRST_NAME VARCHAR2(512);
MY1_SECOND_NAME VARCHAR2(512);
MY1_COMMENT VARCHAR2(512);
MY1_REGION_ID NUMBER;
MY1_FLAT VARCHAR2(512);
MY1_BASE_SUBJECT_ID NUMBER;
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

:MY1_BASE_SUBJECT_ID := MY1_BASE_SUBJECT_ID;
END;
-- END gudik\hydraphp\Builder::getQuery
