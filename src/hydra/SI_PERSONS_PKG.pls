create or replace PACKAGE SI_PERSONS_PKG IS
-- Работа с физическими лицами
-- %author Захариков В.В.

-- Добавление/изменение записи о физическом лице.
-- %param num_N_SUBJECT_ID            Идентификатор физического лица
-- %param num_N_OPF_ID                Идентификатор организационно-правовой формы (справочник REF_TYPE_OPF)
-- %param num_N_FIRM_ID               Идентификатор фирмы
-- %param vch_VC_FIRST_NAME           Имя
-- %param vch_VC_SURNAME              Фамилия
-- %param vch_VC_SECOND_NAME          Отчество
-- %param num_N_SEX_ID                Пол (справочник REF_TYPE_Sex)
-- %param vch_VC_INN                  ИНН
-- %param num_N_DOC_AUTH_TYPE_ID      Идентификатор типа удостоверения личности (справочник REF_TYPE_Document)
-- %param vch_VC_DOC_SERIAL           Серия удостоверения личности
-- %param vch_VC_DOC_NO               Номер удостоверения личности
-- %param dt_D_DOC                    Дата выдачи удостоверения личности
-- %param vch_VC_DOCUMENT             Кем выдано удостоверение личности
-- %param dt_D_BIRTH                  Дата рождения
-- %param vch_VC_BIRTH_PLACE          Место рождения
-- %param vch_VC_PENS_INSURANCE       Данные пенсионного страхования
-- %param vch_VC_MED_INSURANCE        Данные медицинского страхового полиса
-- %param num_N_CITIZENSHIP_ID        Идентификатор гражданства
-- %param vch_VC_KPP                  КПП
-- %param vch_VC_REM                  Примечание
-- %param num_N_SUBJ_STATE_ID         Идентификатор статуса СУ (справочник REF_TYPE_Subject_State)
-- %param num_N_SUBJ_GROUP_ID         Идентификатор группы физических лиц
-- %param vch_VC_DOC_DEPARTMENT       Код подразделения, выдавшего удостоверение личности
-- %param tbl_T_TAGS                  Теги
-- %param num_N_SCN                   Версия
PROCEDURE SI_PERSONS_PUT(
  num_N_SUBJECT_ID                    IN OUT SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_OPF_ID                        IN SI_PERSONS.N_OPF_ID%TYPE := NULL,
  num_N_FIRM_ID                       IN SI_SUBJECTS.N_FIRM_ID%TYPE := NULL,
  vch_VC_FIRST_NAME                   IN SI_PERSONS.VC_NAME%TYPE,
  vch_VC_SURNAME                      IN SI_PERSONS.VC_SURNAME%TYPE := NULL,
  vch_VC_SECOND_NAME                  IN SI_PERSONS.VC_SECOND_NAME%TYPE := NULL,
  num_N_SEX_ID                        IN SI_PERSONS.N_SEX_ID%TYPE := NULL,
  vch_VC_INN                          IN SI_PERSONS.VC_INN%TYPE := NULL,
  num_N_DOC_AUTH_TYPE_ID              IN SI_PERSONS.N_DOC_AUTH_TYPE_ID%TYPE := NULL,
  vch_VC_DOC_SERIAL                   IN SI_PERSONS.VC_DOC_SERIAL%TYPE := NULL,
  vch_VC_DOC_NO                       IN SI_PERSONS.VC_DOC_NO%TYPE := NULL,
  dt_D_DOC                            IN SI_PERSONS.D_DOC%TYPE := NULL,
  vch_VC_DOCUMENT                     IN SI_PERSONS.VC_DOCUMENT%TYPE := NULL,
  dt_D_BIRTH                          IN SI_PERSONS.D_BIRTH%TYPE := NULL,
  vch_VC_BIRTH_PLACE                  IN SI_PERSONS.VC_BIRTH_PLACE%TYPE := NULL,
  vch_VC_PENS_INSURANCE               IN SI_PERSONS.VC_PENS_INSURANCE%TYPE := NULL,
  vch_VC_MED_INSURANCE                IN SI_PERSONS.VC_MED_INSURANCE%TYPE := NULL,
  num_N_CITIZENSHIP_ID                IN SI_PERSONS.N_CITIZENSHIP_ID%TYPE := NULL,
  vch_VC_KPP                          IN SI_PERSONS.VC_KPP%TYPE := NULL,
  vch_VC_REM                          IN SI_SUBJECTS.VC_REM%TYPE := NULL,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE := NULL,
  num_N_SUBJ_GROUP_ID                 IN SI_SUBJ_GROUPS.N_SUBJ_GROUP_ID%TYPE := NULL,
  vch_VC_DOC_DEPARTMENT               IN SI_PERSONS.VC_DOC_DEPARTMENT%TYPE := NULL,
  tbl_T_TAGS                          IN TAGS := NULL,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL);

-- Изменение записи о физическом лице без изменения персональных данных.
-- %param num_N_SUBJECT_ID            Идентификатор физического лица
-- %param num_N_OPF_ID                Идентификатор организационно-правовой формы (справочник REF_TYPE_OPF)
-- %param vch_VC_FIRST_NAME           Имя
-- %param vch_VC_SURNAME              Фамилия
-- %param vch_VC_SECOND_NAME          Отчество
-- %param num_N_SEX_ID                Пол (справочник REF_TYPE_Sex)
-- %param num_N_SUBJ_GROUP_ID         Идентификатор группы СУ
-- %param vch_VC_INN                  ИНН
-- %param dt_D_BIRTH                  Дата рождения
-- %param vch_VC_REM                  Примечание
-- %param num_N_SUBJ_STATE_ID         Идентификатор статуса СУ (справочник REF_TYPE_Subject_State)
-- %param num_N_SUBJ_GROUP_ID         Идентификатор группы физических лиц
PROCEDURE SI_PERSONS_CHG_NO_PRIVATE(
  num_N_SUBJECT_ID                    IN OUT SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_OPF_ID                        IN SI_PERSONS.N_OPF_ID%TYPE,
  vch_VC_FIRST_NAME                   IN SI_PERSONS.VC_NAME%TYPE,
  vch_VC_SURNAME                      IN SI_PERSONS.VC_SURNAME%TYPE,
  vch_VC_SECOND_NAME                  IN SI_PERSONS.VC_SECOND_NAME%TYPE,
  num_N_SEX_ID                        IN SI_PERSONS.N_SEX_ID%TYPE,
  num_N_SUBJ_GROUP_ID                 IN SI_SUBJ_GROUPS.N_SUBJ_GROUP_ID%TYPE,
  vch_VC_INN                          IN SI_PERSONS.VC_INN%TYPE,
  dt_D_BIRTH                          IN SI_PERSONS.D_BIRTH%TYPE,
  vch_VC_REM                          IN SI_SUBJECTS.VC_REM%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE);

-- Удаление записи о физлице.
-- %param num_N_SUBJECT_ID            Идентификатор физического лица
PROCEDURE SI_PERSONS_DEL(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE);

END SI_PERSONS_PKG;